#!/bin/sh

#sketchybar --set $NAME icon="$(date '+%a %d. %b')" label="$(date '+%H:%M')"
sketchybar --set "$NAME" label="$(date '+%a %m/%d %H:%M')"
