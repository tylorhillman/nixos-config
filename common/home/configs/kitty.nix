{ pkgs, host, ... }:

let
  shell = "${pkgs.fish}/bin/fish";
  size = host.term-font-size;

in {
  xdg.configFile."kitty/kitty.conf".source = pkgs.runCommand "kitty-config" {} ''
  # Kitty config file to out var
  cat ${../dotfiles/kitty/kitty.conf} > $out

  # Nix injections
  echo "" >> $out
  echo "# Nix injections" >> $out
  echo "font_size ${toString size}" >> $out
  echo "shell ${toString shell}" >> $out
  '';
}
