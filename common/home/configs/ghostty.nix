{ pkgs, host, ... }:

let
  size = host.term-font-size;
  
in
{
  xdg.configFile."ghostty/config.ghostty".source = pkgs.runCommand "ghostty-config" {} ''
  # Take the content of the dotfile, write it to var $out
  cat ${../dotfiles/ghostty/config} > $out

  # Write out the config template in order
  echo "" >> $out
  echo "# Injected from nix file" >> $out
  echo "font-size = ${toString size}" >> $out
  '';
}
