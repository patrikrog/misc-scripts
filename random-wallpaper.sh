#!/bin/bash
WALLPAPER=$(find ~/Pictures/bakgrunder/tiles/ -name "*.*" | shuf -n 1)
feh --bg-tile "$WALLPAPER" && notify-send "Changed wallpaper" "$WALLPAPER"
