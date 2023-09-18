#!/bin/bash
type=$1
dirpath="$(date +'%Y')/$(date +'%m')"
filename="$(date +'%Y-%m-%d %H%M%S').png"
savepath="$HOME/Pictures/screenshots"

if [ ! -d "$savepath/$dirpath" ]
then
	mkdir -p "$savepath/$dirpath"
fi

case $type in
	"window")
		grim -g "$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')" "$savepath/$dirpath/$filename"
		;;
	"region")
		grim -g "$(slurp)" "$savepath/$dirpath/$filename"
		;;
	"fullscreen")
		grim "$savepath/$dirpath/$filename"
		;;
	*)
		echo "No argument supplied"
		exit 1
		;;
esac

bash $HOME/.local/bin/imageupload-wl "$savepath/$dirpath/$filename"
