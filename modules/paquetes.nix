# =============================================================================
# Paquetes
# =============================================================================

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # --- Terminal ---
    kitty
    starship        # Prompt bonito para fish
    fastfetch       # Info del sistema al abrir terminal
    yazi            # File manager TUI

    # --- Editores ---
    helix           # Editor moderno, "pilas incluidas", sin config necesaria
    # neovim        # Disponible si se quiere explorar en el futuro

    # --- Herramientas básicas ---
    curl
    wget
    git
    tree
    nmap
    usbutils
    fastfetch
    pciutils
    p7zip
    unzip
    jq
    onlyoffice-desktopeditors
    pandoc

    # --- Diagnóstico de hardware ---
    htop
    lm_sensors
    powertop
    intel-gpu-tools
    libva-utils
    mesa-demos
    inxi

    # --- Aplicaciones de escritorio ---
    librewolf               # Navegador principal
    obsidian                # Notas / documentación homelab
    thunderbird             # Correo
    remmina                 # Escritorio remoto
    gparted                 # Gestor de particiones
    keepassxc               # Gestor de contraseñas
    vlc                     # Reproductor multimedia (compatible con todo)
    mpv                     # Reproductor ligero para Wayland
    imv                     # Visor de imágenes Wayland
    zathura                 # Visor de PDF ligero
    pavucontrol             # Control de volumen PipeWire/PulseAudio
    tumbler                        # miniaturas en gestores de archivos
    ffmpegthumbnailer              # miniaturas de vídeo
    karere
    telegram-desktop

    # --- Gestor de archivos gráfico ---
    nautilus

    # --- Hyprland ecosystem ---
    waybar                  # Barra de estado
    dunst                   # Notificaciones
    hyprlock                # Bloqueo de pantalla
    hypridle                # Gestión de inactividad
    hyprsunset              # Temperatura de color (night mode)
    hyprpicker              # Selector de color
    wlogout                 # Menú de salida/apagado
    rofi            # Lanzador de apps (versión Wayland)
    avizo                   # OSD para brillo/volumen
    swappy                  # Editor rápido de capturas
    awww
    waypaper
    networkmanagerapplet    # Wifi integrado

    # --- Capturas de pantalla ---
    grim                    # Captura Wayland
    slurp                   # Selección de área
    wl-screenrec            # Grabación de pantalla
    wl-clipboard

    # --- Portapapeles ---
    wl-clipboard            # wl-copy / wl-paste
    cliphist                # Historial de portapapeles
    wl-clip-persist         # Mantiene portapapeles al cerrar apps

    # --- Control de hardware ---
    brightnessctl           # Brillo de pantalla
    playerctl               # Control multimedia (play/pause/next)
    pamixer                 # Control de volumen por CLI

    # --- Red ---
    networkmanagerapplet    # nm-applet para waybar

    # --- Temas e iconos ---
    bibata-cursors
    papirus-icon-theme
    (catppuccin-gtk.override {
    accents = [ "blue" ];
    variant = "macchiato";
    })
    catppuccin-sddm
    pkgs.libsForQt5.qt5ct  # para configurar Qt visualmente si hace falta

    # --- Login ---
    tuigreet

  ];

  # --- Fuentes ---
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-color-emoji
  ];
}
