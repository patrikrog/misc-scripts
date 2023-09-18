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
		maim -i $(xdotool getactivewindow) "$savepath/$dirpath/$filename"
		;;
	"region")
		maim -s "$savepath/$dirpath/$filename"
		;;
	"screen")
		maim "$savepath/$dirpath/$filename"
		;;
	*)
		echo "No argument supplied"
		exit 1
		;;
esac

bash $HOME/.local/bin/imageupload "$savepath/$dirpath/$filename"
