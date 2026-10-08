# =============================================================================
# KDE Connect — integración con el móvil (notificaciones, portapapeles, etc.)
# =============================================================================
{ pkgs, ... }:
{
  # Instala KDE Connect (Qt6) y abre 1714-1764 TCP/UDP en el firewall
  programs.kdeconnect = {
    enable  = true;
    package = pkgs.kdePackages.kdeconnect-kde;
  };
}

