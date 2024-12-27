#!/bin/sh

AEROSPACE_FOCUSED_MONITOR_NO=$(aerospace list-workspaces --focused)
# AEROSPACE_LIST_OF_WINDOWS_IN_FOCUSED_MONITOR=$(aerospace list-windows --workspace $AEROSPACE_FOCUSED_MONITOR_NO | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

if [ "$SENDER" = "front_app_switched" ]; then

  sketchybar --set "$NAME" label=$(echo "$INFO" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
  # sketchybar --set space.$AEROSPACE_FOCUSED_MONITOR_NO label="$icon_strip"
fi
