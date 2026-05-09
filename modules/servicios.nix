# =============================================================================
# Servicios del sistema
# =============================================================================

{ config, pkgs, ... }:

{
  # --- Tailscale ---
  services.tailscale = {
    enable         = true;
    extraUpFlags    = [ "--accept-routes" "--accept-dns=false" ];
  };

  networking.nameservers = [ "192.168.1.1" "1.1.1.1" ];  # IP de tu Flint2 en LAN
  # --- Syncthing ---
  services.syncthing = {
    enable           = true;
    user             = "aesarbil";
    dataDir          = "/home/aesarbil";
    configDir        = "/home/aesarbil/.config/syncthing";
    openDefaultPorts = true;
  };

  # --- Impresión ---
  services.printing.enable = true;

  # --- Actualizaciones de firmware ---
  services.fwupd.enable = true;

  # --- xserver (necesario para xkb aunque no uses X11) ---
  services.xserver.enable = true;
  
  # --- Wifi
  programs.nm-applet.enable = true;

}
