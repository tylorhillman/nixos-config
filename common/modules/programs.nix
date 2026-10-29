# programs.nix

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
  # A
  
  # B
  
  # C
  
  # D
  discord
  
  # E
  
  # F
  fish
  firefox
  
  # G
  git
  grok-build
  ghostty
  gnupg
  
  # H
  hyprlauncher
  helix
  
  # I
  irssi
  ibm-plex
    
  # J
  
  # K
  
  # L
  
  # M
  
  # N
  nixd
  
  # O
  odin
  ols
  
  # P
  pi-coding-agent
  pass
  pinentry-curses
  
  # Q

  # R
  
  # S
  steam
  senpai
  
  # T
  tree
  
  # U
  
  # V
  
  # W
  weechat
  wl-clipboard
  
  # X
  
  # Y
  
  # Z
  zig
  zls

  ];

  # Enabling Programs
  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.steam.enable = true;

  # Setting UWSM so that way it can serve a fake "desktop"
  programs.hyprland.withUWSM = true;
}
