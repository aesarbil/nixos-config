# =============================================================================
# NixOS - ThinkPad X260 (aesarbil)
# =============================================================================
{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/hardware.nix
    ./modules/red.nix
    ./modules/localizacion.nix
    ./modules/escritorio.nix
    ./modules/audio.nix
    ./modules/energia.nix
    ./modules/servicios.nix
    ./modules/usuario.nix
    ./modules/paquetes.nix
    ./modules/kdeconnect.nix
    ./modules/bluetooth.nix
  ];
  # ===========================================================================
  # NIX
  # ===========================================================================
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  # ===========================================================================
  # NH — rebuilds con progreso/diff + limpieza automática
  # (sustituye a nix.gc: no tener los dos a la vez)
  # ===========================================================================
  programs.nh = {
    enable = true;
    flake  = "/etc/nixos";
    clean = {
      enable    = true;
      dates     = "weekly";
      extraArgs = "--keep-since 30d --keep 5";
    };
  };
  # ===========================================================================
  # VERSIÓN (no cambiar manualmente)
  # ===========================================================================
  system.stateVersion = "25.11";
}
