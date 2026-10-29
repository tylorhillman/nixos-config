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
}
