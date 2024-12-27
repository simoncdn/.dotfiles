#!/usr/bin/env sh

aerospace=(
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
