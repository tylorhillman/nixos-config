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
