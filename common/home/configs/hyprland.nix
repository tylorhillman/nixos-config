{ pkgs, lib, host, ... }:

{
  home.activation.reloadHyprland = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    runtime="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
    if [[ -d "$runtime/hypr" ]]; then
      for dir in "$runtime"/hypr/*; do
        [[ -S "$dir/.socket.sock" ]] || continue
        run ${pkgs.hyprland}/bin/hyprctl --instance "$(basename "$dir")" reload || true
      done
    fi
  '';

  xdg.configFile."hypr/hyprland.lua".source = ../dotfiles/hypr/hyprland.lua;
  xdg.configFile."hypr/modules/programs.lua".source = ../dotfiles/hypr/programs.lua;
  xdg.configFile."hypr/modules/autostart.lua".source = ../dotfiles/hypr/autostart.lua;
  xdg.configFile."hypr/modules/env.lua".source = ../dotfiles/hypr/env.lua;
  xdg.configFile."hypr/modules/permissions.lua".source = ../dotfiles/hypr/permissions.lua;
  xdg.configFile."hypr/modules/look.lua".source = ../dotfiles/hypr/look.lua;
  xdg.configFile."hypr/modules/misc.lua".source = ../dotfiles/hypr/misc.lua;
  xdg.configFile."hypr/modules/input.lua".source = ../dotfiles/hypr/input.lua;
  xdg.configFile."hypr/modules/keybindings.lua".source = ../dotfiles/hypr/keybindings.lua;
  xdg.configFile."hypr/modules/windows.lua".source = ../dotfiles/hypr/windows.lua;

  xdg.configFile."hypr/modules/monitors.lua".text = ''
    -- See https://wiki.hypr.land/Configuring/Basics/Monitors/
    hl.monitor({
        output   = "",
        mode     = "${host.monitor}",
        position = "auto",
        scale    = "auto",
    })
  '';
}
