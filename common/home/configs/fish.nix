{ ... }:

{
  xdg.configFile."fish/config.fish".source = ../dotfiles/fish/config.fish;
  xdg.configFile."fish/conf.d/gpg.fish".source = ../dotfiles/fish/gpg.fish;
}
