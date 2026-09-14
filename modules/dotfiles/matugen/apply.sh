#!/usr/bin/env bash
WALLPAPER=$(grep "^wallpaper" ~/.config/waypaper/config.ini | cut -d= -f2 | tr -d ' ' | sed "s|~|$HOME|g")
matugen image "$WALLPAPER" --quiet --mode dark --source-color-index 0
sleep 1
pkill swaync
sleep 0.5
swaync &

source ~/.config/matugen/wob-colors.sh

cat > ~/.config/wob/wob.ini << WOBEOF
background_color=${WOB_BG}ee
border_color=${WOB_BORDER}ff
bar_color=${WOB_FG}ff
WOBEOF

pkill wob
sleep 0.3
rm -f /tmp/wobpipe
mkfifo /tmp/wobpipe
tail -f /tmp/wobpipe | wob &
