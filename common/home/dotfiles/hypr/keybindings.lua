local programs = require("modules.programs")

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(programs.terminal))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(programs.menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(programs.browser))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd("hyprshot --clipboard-only -m region"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen_state({ action = "toggle", internal = 1, client = 1 }))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Swap the focused window with its neighbor, as in Omarchy.
for _, direction in ipairs({ "left", "right", "up", "down" }) do
    hl.bind(mainMod .. " + SHIFT + " .. direction, hl.dsp.window.swap({ direction = direction }))
end

-- Omarchy-style keyboard resizing: physical -/= keys, with three step sizes.
for _, step in ipairs({ { "", 100 }, { "ALT + ", 25 }, { "CTRL + ", 300 } }) do
    local mod, size = step[1], step[2]
    hl.bind(mainMod .. " + " .. mod .. "code:20", hl.dsp.window.resize({ x = -size, y = 0, relative = true }))
    hl.bind(mainMod .. " + " .. mod .. "code:21", hl.dsp.window.resize({ x = size, y = 0, relative = true }))
    hl.bind(mainMod .. " + SHIFT + " .. mod .. "code:20", hl.dsp.window.resize({ x = 0, y = -size, relative = true }))
    hl.bind(mainMod .. " + SHIFT + " .. mod .. "code:21", hl.dsp.window.resize({ x = 0, y = size, relative = true }))
end

-- Cycle each workspace through dwindle, scrolling and floating.  Remember which
-- windows we floated so independently floating dialogs stay floating afterward.
local workspace_modes = {}
local mode_tag = "workspace-mode-floated"
local function arrange_mode_window(window, floating)
    local claimed = false
    for _, tag in ipairs(window.tags or {}) do
        if tag == mode_tag then claimed = true end
    end
    if floating and not window.floating and (window.fullscreen or 0) == 0 then
        hl.dispatch(hl.dsp.window.tag({ tag = "+" .. mode_tag, window = window }))
        hl.dispatch(hl.dsp.window.float({ action = "on", window = window }))
    elseif not floating and claimed and not window.pinned then
        hl.dispatch(hl.dsp.window.tag({ tag = "-" .. mode_tag, window = window }))
        hl.dispatch(hl.dsp.window.float({ action = "off", window = window }))
    end
end

function cycle_workspace_mode(back)
    local workspace = hl.get_active_workspace()
    if not workspace or not workspace.id or workspace.id < 1 then return end
    local id = tostring(workspace.id)
    local modes = { "dwindle", "scrolling", "floating" }
    local current = workspace_modes[id] or "dwindle"
    local index = 1
    for i, mode in ipairs(modes) do if mode == current then index = i end end
    local next_mode = modes[((index - 1 + (back and -1 or 1)) % #modes) + 1]
    workspace_modes[id] = next_mode
    if next_mode ~= "floating" then
        hl.workspace_rule({ workspace = id, layout = next_mode })
    end
    for _, window in ipairs(hl.get_workspace_windows(id)) do
        arrange_mode_window(window, next_mode == "floating")
    end
    hl.dispatch(hl.dsp.exec_cmd("notify-send 'Workspace layout' '" .. next_mode .. "'"))
end

hl.on("window.open", function(window)
    local id = window.workspace and tostring(window.workspace.id)
    if workspace_modes[id] == "floating" then arrange_mode_window(window, true) end
end)
hl.on("window.move_to_workspace", function(window, workspace)
    hl.timer(function()
        arrange_mode_window(window, workspace_modes[tostring(workspace.id)] == "floating")
    end, { type = "oneshot", timeout = 1 })
end)
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprctl eval 'cycle_workspace_mode(false)'"))
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("hyprctl eval 'cycle_workspace_mode(true)'"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
