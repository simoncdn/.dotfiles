#!/bin/sh

front_app=(
	icon=
	icon.font="$FONT_ICONS:Bold:14.0"
  icon.padding_right=0
	icon.padding_left=8

  label.font="$FONT:Bold:16.0"
	label.padding_right=8

	blur_radius=6
  display=active
  script="$PLUGIN_DIR/front_app.sh"
  click_script="open -a 'Mission Control'"
	background.color=$COLOR_BACKGROUND
)
sketchybar --add item front_app left         \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched
