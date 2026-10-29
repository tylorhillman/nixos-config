# home.nix

{ inputs, ... }:

let

  cfgs = map (file: ./configs + "/${file}") (
    builtins.filter (file: inputs.nixpkgs.lib.hasSuffix ".nix" file) (
        builtins.attrNames (builtins.readDir ./configs)
      )
); 
  
in
{
  home.username = "tylor";
  home.homeDirectory = "/home/tylor";

  imports = cfgs;
  
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
