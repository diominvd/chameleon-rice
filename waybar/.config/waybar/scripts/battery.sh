#!/usr/bin/env bash

BAT_PATH="/sys/class/power_supply/BAT0"
CAPACITY=$(cat "$BAT_PATH/capacity")
STATUS=$(cat "$BAT_PATH/status")

icons=("" "" "" "" "" "" "" "" "" "" "")
icon_index=$(( CAPACITY / 10 ))
[ $icon_index -gt 10 ] && icon_index=10
ICON="${icons[$icon_index]}"

ECO_ICON="" 

CLASS="normal"
[ "$STATUS" = "Charging" ] && ICON="" && CLASS="charging"

if powerprofilesctl get 2>/dev/null | grep -q 'power-saver'; then
    CLASS="eco"
    ICON="$ECO_ICON"
fi

echo "{\"text\": \"$ICON  $CAPACITY%\", \"class\": \"$CLASS\"}"
