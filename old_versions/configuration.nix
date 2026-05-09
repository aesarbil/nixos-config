# =============================================================================
# NixOS - ThinkPad X260 (aesarbil)
# =============================================================================

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # ===========================================================================
  # BOOT
  # ===========================================================================

  boot.loader.systemd-boot.enable = true;
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

  # ===========================================================================
  # HARDWARE
  # ===========================================================================

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };

  hardware.cpu.intel.updateMicrocode = true;

  # ===========================================================================
  # SISTEMA DE ARCHIVOS Y ALMACENAMIENTO
  # ===========================================================================

  fileSystems."/" = {
    options = [ "noatime" ];
  };

  fileSystems."/home" = {
    options = [ "noatime" ];
  };

  services.fstrim.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 60;
  };

  # ===========================================================================
  # RED
  # ===========================================================================

  networking.hostName = "thinkpad-x260";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  # ===========================================================================
  # LOCALIZACIÓN
  # ===========================================================================

  time.timeZone = "Europe/Madrid";

  i18n.defaultLocale = "es_ES.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT    = "es_ES.UTF-8";
    LC_MONETARY       = "es_ES.UTF-8";
    LC_NAME           = "es_ES.UTF-8";
    LC_NUMERIC        = "es_ES.UTF-8";
    LC_PAPER          = "es_ES.UTF-8";
    LC_TELEPHONE      = "es_ES.UTF-8";
    LC_TIME           = "es_ES.UTF-8";
  };

  console.keyMap = "es";

  # ===========================================================================
  # ESCRITORIO — GNOME + HYPRLAND
  # ===========================================================================

  services.xserver.enable = true;
  services.xserver.xkb = {
    layout  = "es";
    variant = "nodeadkeys";
  };

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    gnome-music
    epiphany
    geary
    totem
    gnome-contacts
    gnome-initial-setup
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };


programs.fish.enable = true;

  # xdg-portal necesario para Hyprland (capturas, compartir pantalla)
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  # ===========================================================================
  # AUDIO — PipeWire
  # ===========================================================================

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;
  };

  # ===========================================================================
  # GESTIÓN DE ENERGÍA — TLP
  # ===========================================================================

  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC    = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT   = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0  = 90;
      START_CHARGE_THRESH_BAT1 = 75;
      STOP_CHARGE_THRESH_BAT1  = 90;

      WIFI_PWR_ON_AC  = "off";
      WIFI_PWR_ON_BAT = "off";
    };
  };

  services.thermald.enable = true;

  # ===========================================================================
  # SERVICIOS
  # ===========================================================================

  services.tailscale.enable = true;
  services.tailscale.extraUpFlags = [ "--accept-routes" ];

  services.syncthing = {
    enable           = true;
    user             = "aesarbil";
    dataDir          = "/home/aesarbil";
    configDir        = "/home/aesarbil/.config/syncthing";
    openDefaultPorts = true;
  };

  services.printing.enable = true;
  services.fwupd.enable    = true;

  # ===========================================================================
  # USUARIO
  # ===========================================================================

  users.users.aesarbil = {
    isNormalUser = true;
    description  = "Antonio";
    extraGroups  = [ "networkmanager" "wheel" "video" "audio" "input" ];
  };

  # ===========================================================================
  # NIX
  # ===========================================================================

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates     = "weekly";
    options   = "--delete-older-than 30d";
  };

  # ===========================================================================
  # PAQUETES
  # ===========================================================================

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [

    # --- Terminal y editores ---
    kitty
    neovim

    # --- Herramientas básicas ---
    curl
    wget
    git
    tree
    nmap
    usbutils
    pciutils
    p7zip
    unzip
    jq

    # --- Diagnóstico de hardware ---
    htop
    lm_sensors
    powertop
    intel-gpu-tools
    libva-utils
    mesa-demos
    inxi

    # --- Aplicaciones ---
    librewolf
    obsidian
    vlc
    thunderbird
    remmina
    gparted
    keepassxc
    xfce.thunar          # Gestor de archivos para Hyprland

    # --- Hyprland ecosystem ---
    waybar          # Barra de estado
    dunst           # Notificaciones
    hyprpaper       # Fondo de pantalla
    hyprlock        # Bloqueo de pantalla
    rofi            # Lanzador de apps
    grim            # Capturas de pantalla
    slurp           # Selección de área para capturas
    wl-clipboard    # Portapapeles Wayland
    cliphist        # Historial portapapeles
    brightnessctl   # Control de brillo
    playerctl       # Control multimedia
    libnotify       # notify-send
    networkmanagerapplet  # nm-applet para waybar
    pavucontrol     # Control de volumen
    fish


    # --- Iconos y temas ---
    bibata-cursors
    adwaita-icon-theme
    hicolor-icon-theme
    papirus-icon-theme

    # Prueba 

    helix
    kitty
    starship
    fastfetch
    waybar
    dunst
    libnotify
    avizo
    hyprsunset
    xfce.thunar
    yazi
    qutebrowser
    mpv
    imv
    zathura
    swappy
    grim
    slurp
    wl-screenrec
    hyprpicker
    wl-clipboard
    cliphist
    wl-clip-persist
    hypridle
    hyprlock
    wlogout
    hyprpaper
    catppuccin-gtk
    catppuccin-plymouth
    colloid-icon-theme
    numix-icon-theme-circle
    brightnessctl
    playerctl
    pamixer



  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-color-emoji
  ];

  # ===========================================================================
  # VERSIÓN (no cambiar manualmente)
  # ===========================================================================

  system.stateVersion = "25.11";

}
