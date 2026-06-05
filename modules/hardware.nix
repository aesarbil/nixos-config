# =============================================================================
# Hardware — ThinkPad X260 (Intel Skylake i5/i7, HD Graphics 520)
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

  # --- Parámetros del kernel para Skylake + HD 520 ---
  boot.kernelParams = [

    # Frame Buffer Compression: comprime el framebuffer en VRAM.
    # Menos ancho de banda de memoria = menos consumo del iGPU
    "i915.enable_fbc=1"

    # Desactiva el watchdog NMI: genera interrupciones periódicas que en
    # un portátil de uso normal no sirven para nada
    "nmi_watchdog=0"

    # El kernel escribe datos pendientes a disco cada 60s en vez de cada 5s.
    # Permite que el SSD entre en suspensión más tiempo entre escrituras
    "vm.dirty_writeback_centisecs=6000"
  ];

  # --- Touchpad: forzar I2C en lugar de PS/2 legacy ---
  # Mejor precisión y gestos multitouch en el Synaptics del X260
  boot.extraModprobeConfig = ''
    options psmouse synaptics_intertouch=1
  '';

  # --- Sistema de archivos ---
  # noatime: no actualiza timestamps de acceso en cada lectura → menos I/O
  fileSystems."/" = {
    options = [ "noatime" ];
  };
  fileSystems."/home" = {
    options = [ "noatime" ];
  };

  # TRIM periódico para mantener rendimiento y vida útil del SSD SATA (SPCC)
  services.fstrim.enable = true;

  # --- ZRAM ---
  # 60% de RAM como swap comprimido con zstd. Evita swap en disco por completo.
  # Con 15GB de RAM esto te da ~9GB de swap virtual sin tocar el SSD
  zramSwap = {
    enable        = true;
    algorithm     = "zstd";
    memoryPercent = 60;
  };
}
