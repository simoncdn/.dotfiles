#!/bin/sh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100) ICON="󰁹"
  ;;
  [8-9][0-9]) ICON="󰂁"
  ;;
  [7-8][0-9]) ICON="󰂀"
  ;;
  [6-7][0-9]) ICON="󰁿"
  ;;
  [5-6][0-9]) ICON="󰁾"
  ;;
  [4-5][0-9]) ICON="󰁽"
  ;;
  [3-4][0-9]) ICON="󰁼"
  ;;
  [2-3][0-9]) ICON="󰁻"
  ;;
  [1-2][0-9]) ICON="󰁺"
  ;;
  *) ICON="󰂎"
esac

if [[ "$CHARGING" != "" ]]; then
  ICON=""
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%"
