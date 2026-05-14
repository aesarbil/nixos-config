# =============================================================================
# Servicios del sistema
# =============================================================================
{ config, pkgs, ... }:
{
  # --- Tailscale ---
  services.tailscale = {
    enable       = true;
    extraUpFlags = [ "--accept-routes" "--accept-dns=false" ];
  };
  networking.nameservers = [ "192.168.1.1" "1.1.1.1" ]; # IP Flint2 en LAN

  # --- Syncthing ---
  services.syncthing = {
    enable           = true;
    user             = "aesarbil";
    dataDir          = "/home/aesarbil";
    configDir        = "/home/aesarbil/.config/syncthing";
    openDefaultPorts = true;
    overrideDevices  = true; # Nix manda, los cambios desde la web se ignoran
    overrideFolders  = true;
    systemService    = true;  # <-- añade esto

    settings = {
      devices = {
        nas = {
          id   = "5UQZP4R-FH2QARX-YILODD4-6KD6THT-VTM4WH7-P2DECOI-XNSQSEF-BHL5DA3";
          name = "aesarbilNas";
        };
      };

      folders = {
        # Fotos — bidireccional
        "tqkch-ej5uf" = {
          label   = "Fotos";
          path    = "/home/aesarbil/Imágenes/Fotos";
          devices = [ "nas" ];
          type    = "sendreceive";
        };

        # Familia — bidireccional
        "Familia" = {
          label   = "Familia";
          path    = "/home/aesarbil/Familia";
          devices = [ "nas" ];
          type    = "sendreceive";
        };

        # Dotfiles — solo envía al NAS, el NAS no escribe aquí
        "xpsze-fkc7b" = {
          label   = "Dotfiles";
          path    = "/home/aesarbil/.config";
          devices = [ "nas" ];
          type    = "sendreceive";
        };
      };
    };
  };

  # --- Impresión ---
  services.printing.enable = true;

  # --- Actualizaciones de firmware ---
  services.fwupd.enable = true;

  # --- xserver (necesario para xkb aunque no uses X11) ---
  services.xserver.enable = true;

  # --- Wifi ---
  programs.nm-applet.enable = true;
}
