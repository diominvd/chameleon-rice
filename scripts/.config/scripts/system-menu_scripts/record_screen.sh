#!/usr/bin/env bash

SAVE_DIR="$HOME/Videos/Screenrecords"
mkdir -p "$SAVE_DIR"

if pgrep -x "wf-recorder" > /dev/null; then
    pkill -INT wf-recorder
    notify-send -i camera-video "Recording stopped" "Video saved to $SAVE_DIR"
    exit 0
else
    filename="$SAVE_DIR/rec_$(date +%Y%m%d_%H%M%S).mp4"
    AUDIO_DEVICE=$(pactl get-default-sink).monitor
    notify-send -i camera-video "Recording started"
    time sleep 0.2
    wf-recorder --audio="$AUDIO_DEVICE" -c libx264 -p preset=ultrafast -f "$filename" &
fi
