{ config, pkgs, ... }:
{
  home.username      = "aesarbil";
  home.homeDirectory = "/home/aesarbil";
  home.stateVersion  = "25.11";

  imports = [
    ./home/git.nix
  ];

  # Stignore para Syncthing — debe existir antes de que Syncthing arranque
  home.file.".config/.stignore".source = ./dotfiles/stignore;

  # Target puente para graphical-session.target (sin UWSM) — ver histórico 2026-09-12/13
  home.file.".config/systemd/user/hyprland-session.target".source = ./dotfiles/systemd/hyprland-session.target;
}
