#!/usr/bin/env bash
WALLPAPER_DIR="$HOME/Familia/Antonio/Wallpaper/PC/Hyprland"
CACHE_DIR="$HOME/.cache/wp-thumbs"
WAYPAPER_INI="$HOME/.config/waypaper/config.ini"

CURRENT=$(grep "^wallpaper" "$WAYPAPER_INI" | cut -d= -f2 | tr -d ' ')
CURRENT="${CURRENT/#\~/$HOME}"

# Lista ordenada una sola vez
mapfile -t WALLS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | sort)

ROFI_INPUT=""
CURRENT_ROW=0
for i in "${!WALLS[@]}"; do
    img="${WALLS[$i]}"
    name=$(basename "$img")
    # Usar nombre como hash — más rápido que md5
    thumb="$CACHE_DIR/${name%.*}.png"
    [ -f "$thumb" ] && icon="$thumb" || icon="$img"
    if [ "$img" = "$CURRENT" ]; then
        name="▶ $name"
        CURRENT_ROW=$i
    fi
    ROFI_INPUT+="${img}\x00icon\x1f${icon}\x1fdisplay\x1f${name}\n"
done

SELECTED=$(printf "%b" "$ROFI_INPUT" | rofi -dmenu -i -p "wallpaper" \
    -selected-row "$CURRENT_ROW" \
    -theme ~/.config/rofi/themes/wallpaper-picker.rasi)

[ -z "$SELECTED" ] && exit 0

awww img "$SELECTED" --transition-type any --transition-duration 1
sed -i "s|wallpaper = .*|wallpaper = $SELECTED|" "$WAYPAPER_INI"
bash ~/.config/matugen/apply.sh
