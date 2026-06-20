# =============================================================================
# Paquetes
# =============================================================================
{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # --- Terminal ---
    kitty                   # Emulador de terminal GPU-accelerated
    starship                # Prompt bonito y configurable para fish
    fastfetch               # Info del sistema al abrir terminal (neofetch moderno)
    yazi                    # File manager TUI con previsualizaciones
    neovim                  # Editor de codigo

    # --- Editores ---
    helix                   # Editor moderno modal, "pilas incluidas", sin config necesaria
    # neovim                # Disponible si se quiere explorar en el futuro

    # --- Herramientas básicas ---
    curl                    # Transferencia de datos por URL
    wget                    # Descarga de archivos por HTTP/FTP
    git                     # Control de versiones
    tree                    # Visualización de directorios en árbol
    nmap                    # Escáner de red y puertos
    usbutils                # Herramientas USB (lsusb)
    pciutils                # Herramientas PCI (lspci)
    p7zip                   # Compresor/descompresor 7zip
    unzip                   # Descompresor ZIP
    jq                      # Procesador JSON para terminal
    onlyoffice-desktopeditors  # Suite ofimática compatible con Microsoft Office
    pandoc                  # Conversor universal de documentos
    libnotify               # provee notify-send
    nodejs                  # Entorno de ejecución JavaScript — requerido para servidores MCP

    # --- Diagnóstico de hardware ---
    htop                    # Monitor de procesos interactivo
    lm_sensors              # Sensores de temperatura y voltaje
    powertop                # Análisis de consumo energético
    intel-gpu-tools         # Herramientas para GPU Intel (intel_gpu_top)
    libva-utils             # Verificación de aceleración de vídeo VAAPI
    mesa-demos              # Demos OpenGL para verificar aceleración gráfica
    inxi                    # Info detallada del sistema en terminal
    upower                  # Diagnostico de baterias

    # --- Aplicaciones de escritorio ---
    librewolf               # Navegador principal basado en Firefox, privacidad mejorada
    obsidian                # Notas en Markdown / documentación homelab
    thunderbird             # Cliente de correo electrónico
    remmina                 # Cliente de escritorio remoto (RDP, VNC, SSH)
    gparted                 # Gestor gráfico de particiones
    keepassxc               # Gestor de contraseñas local
    vlc                     # Reproductor multimedia compatible con casi todo
    mpv                     # Reproductor multimedia ligero optimizado para Wayland
    imv                     # Visor de imágenes minimalista para Wayland
    zathura                 # Visor de PDF ligero con atajos de teclado vim-like
    pavucontrol             # Control gráfico de volumen PipeWire/PulseAudio
    tumbler                 # Generador de miniaturas para gestores de archivos
    ffmpegthumbnailer       # Miniaturas de vídeo para gestores de archivos
    karere                  # Cliente de MEGA para escritorio
    telegram-desktop        # Cliente de Telegram
    birdtray                # Thunderbird modo daemon

    # --- Gestor de archivos gráfico ---
    nautilus                # Gestor de archivos GNOME, compatible con Hyprland

    # --- Hyprland ecosystem ---
    waybar                  # Barra de estado altamente configurable
    swaynotificationcenter  # Centro de notificaciones estilo móvil
    hyprlock                # Pantalla de bloqueo nativa de Hyprland
    hypridle                # Gestión de inactividad (apagar pantalla, bloquear)
    hyprsunset              # Temperatura de color adaptativa (night mode)
    hyprpicker              # Selector de color con cuentagotas para Wayland
    wleave                  # Menú de salida/apagado/suspensión estilo Wayland
    rofi                    # Lanzador de apps y menú multipropósito (Wayland)
    wob                     # OSD barra minimalista para brillo y volumen
    swappy                  # Editor rápido de capturas de pantalla
    awww                    # Daemon de wallpapers con transiciones animadas
    waypaper                # GUI para selección de wallpapers (backup del script rofi)
    matugen                 # Generador de paletas de color desde el wallpaper
    qt6Packages.qt6ct       # Configuración de temas Qt6

    # --- Capturas de pantalla ---
    grim                    # Captura de pantalla para Wayland
    slurp                   # Selección de área en pantalla para Wayland
    wl-screenrec            # Grabación de pantalla para Wayland

    # --- Portapapeles ---
    wl-clipboard            # wl-copy / wl-paste para Wayland
    cliphist                # Historial de portapapeles integrado con rofi
    wl-clip-persist         # Mantiene el portapapeles al cerrar aplicaciones

    # --- Control de hardware ---
    brightnessctl           # Control de brillo de pantalla por CLI
    playerctl               # Control multimedia por CLI (play/pause/next/prev)
    pamixer                 # Control de volumen por CLI vía PipeWire/PulseAudio

    # --- Red ---
    networkmanagerapplet    # Applet gráfico de NetworkManager para la bandeja

    # --- Temas e iconos ---
    bibata-cursors          # Tema de cursor moderno y limpio
    papirus-icon-theme      # Tema de iconos completo y bien mantenido
    (catppuccin-gtk.override {
      accents = [ "blue" ];
      variant = "macchiato";
    })                      # Tema GTK Catppuccin Macchiato con acento azul
    (catppuccin-sddm.override {
      flavor = "mocha";
      font = "JetBrains Mono";
      fontSize = "14";
      background = "${../assets/sddm-wallpaper.png}";
      loginBackground = true;
    })                      # Tema SDDM Catppuccin con wallpaper personalizado
  ];

  # --- Fuentes ---
  fonts.packages = with pkgs; [
    jetbrains-mono              # Fuente monoespaciada para terminal y editor
    nerd-fonts.jetbrains-mono   # JetBrains Mono con iconos Nerd Fonts
    nerd-fonts.symbols-only     # Solo símbolos Nerd Fonts (complemento)
    noto-fonts                  # Fuentes Noto con soporte unicode amplio
    noto-fonts-color-emoji      # Emojis en color
  ];
}
