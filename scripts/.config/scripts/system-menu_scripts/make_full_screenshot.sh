#!/usr/bin/env bash

SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"

filename="$SAVE_DIR/full_$(date +%Y%m%d_%H%M%S).png"
time sleep 0.2
grim "$filename"
wl-copy < "$filename"
notify-send -i camera-photo "Screenshot Taken" \
    "Full screen saved and copied to clipboard"
