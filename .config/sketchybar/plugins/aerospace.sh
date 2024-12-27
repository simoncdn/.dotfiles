#!/usr/bin/env sh

AEROSPACE_EMPTY_WORKSPACE=$(aerospace list-workspaces --monitor focused --empty)
CURRENT_APP=$(aerospace list-windows --focused | awk '{print $3}' | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then

		sketchybar --set aerospace label="$FOCUSED_WORKSPACE"

		# Adjust padding for keep the same width of the number
		if [[ "$1" = '1' ]]; then
			sketchybar --set aerospace label.padding_right=8
		else
			sketchybar --set aerospace label.padding_right=4
		fi
		
		if [[ "$AEROSPACE_EMPTY_WORKSPACE" == *"$1"* ]]; then
			sketchybar --set front_app label=".."
		else
			sketchybar --set front_app label="$CURRENT_APP"
		fi
fi
