# programs.nix

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
  # A
  
  # B
  bootdev-cli
  
  # C
  
  # D
  discord
  
  # E
  
  # F
  fish
  firefox
  fastfetch
  file
  flameshot
  
  # G
  go
  git
  grok-build
  ghostty
  gnupg
  
  
  # H
  hyprlauncher
  helix
  hyprpaper
  hyprshot
  
  # I
  irssi
  ibm-plex
  imagemagick
    
  # J
  
  # K
  kitty
  
  # L
  lua
  lua-language-server
  
  # M
  
  # N
  nixd
  noto-fonts-cjk-sans
  nerd-fonts.blex-mono
  
  # O
  odin
  ols
  
  # P
  pi-coding-agent
  pass
  pinentry-curses
  pavucontrol
  
  # Q

  # R
  rofi
  
  # S
  steam
  senpai
  swaylock-effects
  starship
  
  # T
  tre-command
  
  # U
  
  # V
  
  # W
  weechat
  wl-clipboard
  waybar
  
  # X
  xxd
  
  # Y
  yazi
  
  # Z
  zig
  zls

  ];

  # Enabling Programs
  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.steam.enable = true;
  programs.starship.enable = true;
  
  # Setting UWSM so that way it can serve a fake "desktop"
  programs.hyprland.withUWSM = true;
}
