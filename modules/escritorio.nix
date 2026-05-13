{ config, pkgs, ... }:
{
  services.displayManager.sddm = {
    enable         = true;
    wayland.enable = true;
    theme          = "catppuccin-mocha-mauve";
    package        = pkgs.kdePackages.sddm;
    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Classic";
      };
      General = {
        InputMethod = "";
      };
    };
  };

  # Asegura soporte de ratón y touchpad desde el arranque
  services.libinput.enable = true;

  programs.hyprland = {
    enable          = true;
    xwayland.enable = true;
    withUWSM        = false;
  };

  xdg.portal = {
    enable       = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  programs.fish.enable  = true;
  programs.firefox.enable = true;

  environment.variables = {
    GTK_THEME = "catppuccin-macchiato-blue-standard";
  };

  qt = {
    enable        = true;
    platformTheme = "gtk2";
    style         = "gtk2";
  };
}
