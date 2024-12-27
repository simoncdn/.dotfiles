#!/bin/sh

POPUP_OFF='sketchybar --set apple.logo popup.drawing=off'
POPUP_CLICK_SCRIPT='sketchybar --set $NAME popup.drawing=toggle'

logo=(
  icon=
  icon.font="$FONT_ICONS:Bold:16.0"
  icon.color=$COLOR_CYAN
  icon.padding_right=0
	icon.padding_left=8

  label.drawing=off
)

sketchybar --add item logo left \
           --set logo "${logo[@]}"
