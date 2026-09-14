#!/usr/bin/env bash
WALLPAPER_DIR="$HOME/Familia/Antonio/Wallpaper/PC/Hyprland"
CACHE_DIR="$HOME/.cache/wp-thumbs"
mkdir -p "$CACHE_DIR"
find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | while read -r img; do
    hash=$(echo "$img" | md5sum | cut -d' ' -f1)
    thumb="$CACHE_DIR/${hash}.png"
    [ -f "$thumb" ] && continue
    convert "$img" -thumbnail "240x135^" -gravity center -extent "240x135" "$thumb" 2>/dev/null
done
