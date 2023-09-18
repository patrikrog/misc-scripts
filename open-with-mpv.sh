#!/usr/bin/env sh

url=$(xclip -o)
mpv "$url"
if [ $? -ne 0 ]; then
		url="$(rofi -config ~/.config/rofi/config-url.rasi -dmenu)"
		mpv "$url"
fi
