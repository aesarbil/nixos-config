# =============================================================================
# Gestión de energía — TLP
# =============================================================================
{ config, pkgs, ... }:
{
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable   = true;
    settings = {
      # --- CPU governor ---
      # schedutil escala dinámicamente según carga real del scheduler,
      # más responsivo que powersave (que se queda pegado a frecuencia mínima)
      CPU_SCALING_GOVERNOR_ON_AC    = "schedutil";
      CPU_SCALING_GOVERNOR_ON_BAT   = "schedutil";
      # --- Política de energía/rendimiento del CPU ---
      # En AC: balance (no máximo rendimiento, evita calor innecesario en Skylake)
      # En batería: balance_power permite subir frecuencia cuando hay carga real
      # (antes "power" dejaba el i5-6300U a ~400MHz constantes)
      CPU_ENERGY_PERF_POLICY_ON_AC  = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      # --- Límites de rendimiento CPU en batería ---
      # MIN 20%: evita caer al suelo absoluto de frecuencia
      # MAX 80%: evita turbo boost en batería (ahorra energía sin perder fluidez)
      CPU_MIN_PERF_ON_BAT = 20;
      CPU_MAX_PERF_ON_BAT = 80;
      # --- Umbrales de carga para batería ThinkPad ---
      # 75/90 es el rango óptimo para longevidad (evita estrés en extremos)
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0  = 90;
      START_CHARGE_THRESH_BAT1 = 75;
      STOP_CHARGE_THRESH_BAT1  = 90;
      # --- WiFi ---
      # En AC lo dejamos encendido para máxima velocidad de red
      # En batería activamos power saving del driver WiFi
      WIFI_PWR_ON_AC  = "off";
      WIFI_PWR_ON_BAT = "on";
      # --- PCIe ASPM (Active State Power Management) ---
      # Permite que los dispositivos PCIe entren en estados de bajo consumo
      PCIE_ASPM_ON_BAT = "powersupersave";
      # --- USB autosuspend ---
      # Suspende dispositivos USB inactivos en batería
      USB_AUTOSUSPEND = 1;
    };
  };
  services.thermald.enable = true;
  services.logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "suspend";
  };
}
