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
  hexchat
  
  # I
  
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
  
  # Q

  # R
  
  # S
  steam
  
  # T
  tree
  
  # U
  
  # V
  
  # W
  
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
