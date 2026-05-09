# =============================================================================
# Gestión de energía — TLP
# =============================================================================

{ config, pkgs, ... }:

{
  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable   = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC    = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT   = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # Umbrales de carga para batería ThinkPad
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0  = 90;
      START_CHARGE_THRESH_BAT1 = 75;
      STOP_CHARGE_THRESH_BAT1  = 90;

      WIFI_PWR_ON_AC  = "off";
      WIFI_PWR_ON_BAT = "off";
    };
  };

  services.thermald.enable = true;
}
