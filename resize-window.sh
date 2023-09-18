#!/usr/bin/env bash
select_size() {
	selected_val=$(printf '%s\n' "$@" | rofi -dmenu)
	echo $selected_val
}

#ratios=("4:3" "16:9" "16:10")

#sizes_4x3=("640 480" "800 600" "1024 768" "1280 960" "1600 1200")
#sizes_16x9=("1024 576" "1152 648" "1280 720" "1366 768" "1600 900" "1920 1080")
#sizes_16x10=("1024 640" "1280 800" "1440 900" "1680 1050" "1920 1200")
sizes=("640 480" "800 600" "1024 576" "1024 640" "1024 768")
sizes+=("1152 648" "1280 720" "1280 800" "1280 960" "1366 768")
sizes+=("1400 1050" "1440 900" "1600 900" "1600 1200" "1680 1050")
sizes+=("1920 1080" "1920 1200")

#selected_ratio=$(select_size "${ratios[@]}")
selected_size=$(select_size "${sizes[@]}")

#case $selected_ratio in
	#"4:3")
		#selected_size=$(select_size "${sizes_4x3[@]}")
		#;;
	#"16:9")
		#selected_size=$(select_size "${sizes_16x9[@]}")
		#;;
	#"16:10")
		#selected_size=$(select_size "${sizes_16x10[@]}")
		#;;
#esac

width=$(echo $selected_size | cut -f1 -d" ")
height=$(echo $selected_size | cut -f2 -d" ")

xdotool windowsize $(xdotool getactivewindow) $width $height
