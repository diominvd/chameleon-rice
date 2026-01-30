#!/usr/bin/env bash

BAT_PATH="/sys/class/power_supply/BAT0"
[ ! -d "$BAT_PATH" ] && BAT_PATH="/sys/class/power_supply/BAT1"

CAPACITY=$(cat "$BAT_PATH/capacity")
STATUS=$(cat "$BAT_PATH/status")

ENERGY_NOW=$(cat "$BAT_PATH/energy_now" 2>/dev/null || cat "$BAT_PATH/charge_now" 2>/dev/null)
POWER_NOW=$(cat "$BAT_PATH/power_now" 2>/dev/null || cat "$BAT_PATH/current_now" 2>/dev/null)

# Default icons
icons=("" "" "" "" "" "" "" "" "" "" "")
ICON="${icons[$((CAPACITY / 10))]}"
ECO_ICON=""
CLASS="normal"

# Logic for Tooltip and specific Icons
if [[ "$STATUS" == "Not charging" ]] || [[ "$STATUS" == "Full" ]]; then
    ICON="" 
    TOOLTIP="AC Connected (Battery Protected)"
elif [[ "$STATUS" == "Charging" ]]; then
    ICON=""
    CLASS="charging"
    if [[ "$POWER_NOW" -gt 0 ]]; then
        ENERGY_FULL=$(cat "$BAT_PATH/energy_full" 2>/dev/null || cat "$BAT_PATH/charge_full" 2>/dev/null)
        DIFF=$((ENERGY_FULL - ENERGY_NOW))
        HOURS=$(echo "scale=2; $DIFF / $POWER_NOW" | bc)
        TIME_LEFT=$(printf "%02d:%02d" $(echo "$HOURS" | cut -d. -f1) $(echo "($HOURS % 1) * 60" | bc | cut -d. -f1))
        TOOLTIP="Full in: $TIME_LEFT"
    else
        TOOLTIP="Charging: $CAPACITY%"
    fi
elif [[ "$STATUS" == "Discharging" ]]; then
    if [[ "$POWER_NOW" -gt 0 ]]; then
        HOURS=$(echo "scale=2; $ENERGY_NOW / $POWER_NOW" | bc)
        TIME_LEFT=$(printf "%02d:%02d" $(echo "$HOURS" | cut -d. -f1) $(echo "($HOURS % 1) * 60" | bc | cut -d. -f1))
        TOOLTIP="Time remaining: $TIME_LEFT"
    else
        TOOLTIP="Discharging: $CAPACITY%"
    fi
else
    TOOLTIP="Status: $STATUS"
fi

# Override for Eco Mode
if powerprofilesctl get 2>/dev/null | grep -q 'power-saver'; then
    CLASS="eco"
    ICON="$ECO_ICON"
fi

echo "{\"text\": \"$ICON  $CAPACITY%\", \"class\": \"$CLASS\", \"tooltip\": \"$TOOLTIP\"}"
