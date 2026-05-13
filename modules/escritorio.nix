{ config, pkgs, ... }:
{
  # ── Display Manager ────────────────────────────────────────────────────────
  # Greeter corriendo en X11 para evitar el bug del cursor invisible en SDDM
  # wayland (experimental). La sesión de Hyprland sigue arrancando en Wayland.
  services.displayManager.sddm = {
    enable         = true;
    wayland.enable = false;
    theme          = "catppuccin-mocha-mauve";
    package        = pkgs.kdePackages.sddm;
    extraPackages  = with pkgs; [ bibata-cursors ];
    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Classic";
        CursorSize  = 24; # entero, no string
      };
      General = {
        InputMethod = ""; # desactiva el input method virtual (evita lag en el greeter)
      };
    };
  };

  # ── Input ──────────────────────────────────────────────────────────────────
  # Soporte unificado de ratón y touchpad (necesario para Wayland)
  services.libinput.enable = true;

  # ── Compositor ─────────────────────────────────────────────────────────────
  # Hyprland como compositor Wayland principal
  programs.hyprland = {
    enable          = true;
    xwayland.enable = true; # compatibilidad con apps que no soportan Wayland nativo
    withUWSM        = false;
  };

  # ── Portales XDG ───────────────────────────────────────────────────────────
  # Necesarios para screen sharing, file picker, etc. desde apps Wayland/XWayland
  xdg.portal = {
    enable       = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  # ── Programas ──────────────────────────────────────────────────────────────
  programs.fish.enable    = true;
  programs.firefox.enable = true;

  # ── Variables de entorno ───────────────────────────────────────────────────
  environment.variables = {
    GTK_THEME     = "catppuccin-macchiato-blue-standard";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE  = "24";
  };

  # ── Qt ─────────────────────────────────────────────────────────────────────
  # Usa el tema GTK también para apps Qt (coherencia visual)
  qt = {
    enable        = true;
    platformTheme = "gtk2";
    style         = "gtk2";
  };
}
