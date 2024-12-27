#!/bin/sh

left_bar=(
	background.color=$COLOR_BACKGROUND
	blur_radius=$RADIUS
	background.corner_radius=$RADIUS
	background.height=$HEIGHT
	background.border_color=$COLOR_GREY
	background.border_width=1
)
sketchybar  --add bracket left_bar logo aerospace front_app \
						--set left_bar "${left_bar[@]}"
