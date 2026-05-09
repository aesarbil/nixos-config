# =============================================================================
# Hardware
# =============================================================================
{ config, pkgs, ... }:
{
  # --- GPU Intel / VAAPI ---
  hardware.graphics = {
    enable        = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  hardware.cpu.intel.updateMicrocode = true;

  # --- Touchpad: forzar I2C en lugar de PS/2 legacy ---
  boot.extraModprobeConfig = ''
    options psmouse synaptics_intertouch=1
  '';

  # --- Sistema de archivos ---
  fileSystems."/" = {
    options = [ "noatime" ];
  };

  fileSystems."/home" = {
    options = [ "noatime" ];
  };

  services.fstrim.enable = true;

  # --- ZRAM ---
  zramSwap = {
    enable        = true;
    algorithm     = "zstd";
    memoryPercent = 60;
  };
}
