{ config, pkgs, ... }:
{
  home.username      = "aesarbil";
  home.homeDirectory = "/home/aesarbil";
  home.stateVersion  = "25.11";

  imports = [
    ./home/git.nix
  ];

  # Stignore para Syncthing — debe existir antes de que Syncthing arranque
  home.file.".config/.stignore".source = ./dotfiles/stignore;

  # Target puente para graphical-session.target (sin UWSM) — ver histórico 2026-09-12/13
  home.file.".config/systemd/user/hyprland-session.target".source = ./dotfiles/systemd/hyprland-session.target;

  # Hyprland config principal (formato Lua desde la migración 2026-09-13)
  home.file.".config/hypr/hyprland.lua".source = ./dotfiles/hypr/hyprland.lua;

  # --- kitty ---
  home.file.".config/kitty/kitty.conf".source     = ./dotfiles/kitty/kitty.conf;
  home.file.".config/kitty/scroll_mark.py".source = ./dotfiles/kitty/scroll_mark.py;
  home.file.".config/kitty/search.py".source      = ./dotfiles/kitty/search.py;

  # --- matugen ---
  home.file.".config/matugen/apply.sh".source                              = ./dotfiles/matugen/apply.sh;
  home.file.".config/matugen/config.toml".source                           = ./dotfiles/matugen/config.toml;
  home.file.".config/matugen/templates/hyprland-colors.lua.templ".source   = ./dotfiles/matugen/templates/hyprland-colors.lua.templ;
  home.file.".config/matugen/templates/hyprlock-colors.conf.templ".source  = ./dotfiles/matugen/templates/hyprlock-colors.conf.templ;
  home.file.".config/matugen/templates/kitty-colors.conf.templ".source     = ./dotfiles/matugen/templates/kitty-colors.conf.templ;
  home.file.".config/matugen/templates/rofi-colors.rasi.templ".source      = ./dotfiles/matugen/templates/rofi-colors.rasi.templ;
  home.file.".config/matugen/templates/swaync-colors.css.templ".source     = ./dotfiles/matugen/templates/swaync-colors.css.templ;
  home.file.".config/matugen/templates/waybar-colors.css.templ".source     = ./dotfiles/matugen/templates/waybar-colors.css.templ;
  home.file.".config/matugen/templates/wob-colors.sh.templ".source         = ./dotfiles/matugen/templates/wob-colors.sh.templ;
  home.file.".config/matugen/templates/yazi-theme.toml.templ".source       = ./dotfiles/matugen/templates/yazi-theme.toml.templ;

  # --- rofi ---
  home.file.".config/rofi/config.rasi".source                       = ./dotfiles/rofi/config.rasi;
  home.file.".config/rofi/wallpaper-picker.sh".source                = ./dotfiles/rofi/wallpaper-picker.sh;
  home.file.".config/rofi/wp-precache.sh".source                     = ./dotfiles/rofi/wp-precache.sh;
  home.file.".config/rofi/themes/catppuccin-macchiato.rasi".source   = ./dotfiles/rofi/themes/catppuccin-macchiato.rasi;
  home.file.".config/rofi/themes/wallpaper-picker.rasi".source       = ./dotfiles/rofi/themes/wallpaper-picker.rasi;

  # --- swaync ---
  home.file.".config/swaync/config.json".source              = ./dotfiles/swaync/config.json;
  home.file.".config/swaync/style.css".source                = ./dotfiles/swaync/style.css;
  home.file.".config/swaync/Styles/central_control.css".source = ./dotfiles/swaync/Styles/central_control.css;
  home.file.".config/swaync/Styles/notifications.css".source   = ./dotfiles/swaync/Styles/notifications.css;

  # --- waybar ---
  home.file.".config/waybar/config".source    = ./dotfiles/waybar/config;
  home.file.".config/waybar/style.css".source = ./dotfiles/waybar/style.css;
}
