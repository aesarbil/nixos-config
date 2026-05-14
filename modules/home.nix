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
}
