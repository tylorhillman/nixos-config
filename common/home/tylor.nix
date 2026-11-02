# home.nix

{ inputs, ... }:

let

  nixFiles = dir: suffix:
    map (file: dir + "/${file}") (
      builtins.filter (file: inputs.nixpkgs.lib.hasSuffix suffix file) (
        builtins.attrNames (builtins.readDir dir)
      )
    );

  cfgs = nixFiles ./configs ".nix";
  # Palette files live beside these and are imported directly, not as modules.
  themes = nixFiles ./themes "-theme.nix";

in
{
  home.username = "tylor";
  home.homeDirectory = "/home/tylor";

  imports = cfgs ++ themes;
  
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.05";
}
