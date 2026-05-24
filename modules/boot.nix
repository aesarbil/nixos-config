# =============================================================================
# Boot
# =============================================================================
{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable      = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
    "mitigations=off"
    "i915.enable_fbc=1"
    "i915.enable_guc=3"
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
