#!/bin/sh

calendar=(
  icon=
  icon.font="$FONT_ICONS:Bold:14.0"
  icon.padding_right=0
	icon.padding_left=0

	label.font="$FONT:Bold:16.0"
  label.align=right
	label.padding_right=8

  padding_left=12
	blur_radius=6
  update_freq=30
  script="$PLUGIN_DIR/calendar.sh"
  click_script="$PLUGIN_DIR/zen.sh"
)

sketchybar --add item calendar right       \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke
