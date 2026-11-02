set fish_greeting ""

if status is-interactive
    fastfetch --config ~/.config/fastfetch/config.jsonc
end

starship init fish | source
