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
  ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
  };
}
