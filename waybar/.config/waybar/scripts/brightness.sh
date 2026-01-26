#!/usr/bin/env bash

SIGNAL=11
WAYBAR_BIN=waybar
STEP="5%"
BRIGHTNESSCTL=$(command -v brightnessctl)

if [ -z "$BRIGHTNESSCTL" ]; then
    echo '{"text":"err","tooltip":"no brightnessctl"}'
    exit 0
fi

current_percent() {
    local current max
    current=$($BRIGHTNESSCTL get 2>/dev/null)
    max=$($BRIGHTNESSCTL max 2>/dev/null)

    if [ -z "$max" ] || [ "$max" -le 0 ]; then
        echo "0"
        return
    fi

    awk -v cur="$current" -v mx="$max" 'BEGIN { printf "%.0f", (cur / mx) * 100 }'
}

get_info() {
    local percent
    percent=$(current_percent)

    echo "{\"text\":\"${percent}%\", \"tooltip\":\"Brightness Level: ${percent}%\"}"
}

case "$1" in
    --inc)
        $BRIGHTNESSCTL set "+${STEP}" >/dev/null 2>&1
        pkill -RTMIN+"$SIGNAL" "$WAYBAR_BIN" 2>/dev/null
        ;;
    --dec)
        $BRIGHTNESSCTL set "${STEP}-" >/dev/null 2>&1
        pkill -RTMIN+"$SIGNAL" "$WAYBAR_BIN" 2>/dev/null
        ;;
    *)
        get_info
        ;;
esac
