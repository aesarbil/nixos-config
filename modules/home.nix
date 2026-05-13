{ config, pkgs, ... }:
{
  home.username      = "aesarbil";
  home.homeDirectory = "/home/aesarbil";
  home.stateVersion  = "25.11";

  imports = [
    ./home/git.nix
  ];
}
