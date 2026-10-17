# =============================================================================
# Boot
# =============================================================================
{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable      = true;
  boot.loader.systemd-boot.configurationLimit = 10;   # máx. 10 entradas en el menú
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;                             # antes 5 s por defecto

  # Parámetros i915 (Skylake): todos aquí, no duplicar en hardware.nix
  boot.kernelParams = [
    "mitigations=off"
    "i915.enable_fbc=1"
    "i915.enable_psr=0"   # PSR off: bug de Skylake (pipe B atomic update)
    "i915.enable_guc=2"   # solo HuC; GuC submission no existe en Skylake (antes =3)
    "i915.fastboot=1"
    "quiet"
    "splash"
  ];
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };

  # Plymouth — pantalla de arranque
  boot.plymouth = {
    enable = true;
    theme = "catppuccin-macchiato";
    themePackages = [ pkgs.catppuccin-plymouth ];
  };
  boot.initrd.systemd.enable = true;
}
