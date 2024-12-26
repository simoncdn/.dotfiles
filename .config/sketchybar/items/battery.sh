#!/bin/sh

battery=(
  icon.font="$FONT_ICONS:Bold:14.0"
	icon.color=$COLOR_YELLOW
  icon.padding_right=0
	icon.padding_left=8

	label.font="$FONT:Bold:16.0"
	label.color=$COLOR_WHITE

  update_freq=120
  updates=on

	script="$PLUGIN_DIR/battery.sh"
)
sketchybar --add item battery right \
           --set battery "${battery[@]}"\
           --subscribe battery power_source_change system_woke
