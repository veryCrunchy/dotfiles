#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers/Active"
INTERVAL=600

TRANSITIONS=(grow outer wipe center wave zoom fade)

pgrep -x swww || swww-daemon

while true; do
  WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)
  TRANSITION=$(shuf -n1 -e "${TRANSITIONS[@]}")

  swww img "$WALLPAPER" --transition-type "$TRANSITION" --transition-duration 2
  sleep "$INTERVAL"
done
