# =============================================================================
# Bluetooth — hardware + blueman + soporte de códecs
# =============================================================================
{ pkgs, ... }:
{
  hardware.bluetooth = {
    enable      = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental    = true;
        FastConnectable = true;
      };
    };
  };

  services.blueman.enable = true;
}
