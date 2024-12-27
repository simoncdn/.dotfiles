#!/usr/bin/env sh

aerospace=(
	# icon=''
	# icon.font="$FONT_ICONS:Bold:14.0"
	# icon.color=$COLOR_PURPLE
	icon.drawing=off

  label.font="$FONT:Bold:16.0"
	label.color=$COLOR_WHITE
	padding_right=2
	padding_left=8

	script="$PLUGIN_DIR/aerospace.sh"
)

sketchybar --add item aerospace left \
           --set aerospace "${aerospace[@]}"\
           --subscribe aerospace