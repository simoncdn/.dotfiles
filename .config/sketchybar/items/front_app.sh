#!/bin/sh

front_app=(
	icon=
	icon.font="$FONT_ICONS:Bold:14.0"
	icon.color=$COLOR_PURPLE
  icon.padding_right=0
	icon.padding_left=0

  label.font="$FONT:Bold:16.0"
	label.color=$COLOR_WHITE
	label.padding_right=8

	display=active
  script="$PLUGIN_DIR/front_app.sh"
  click_script="open -a 'Mission Control'"
)

sketchybar --add item front_app left         \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched
