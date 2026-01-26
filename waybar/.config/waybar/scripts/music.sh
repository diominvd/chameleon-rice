#!/usr/bin/env bash

ARTIST=$(playerctl metadata --format "{{artist}}" 2>/dev/null)
TITLE=$(playerctl metadata --format "{{title}}" 2>/dev/null)

if [ -z "$TITLE" ]; then
    echo "No music"
    exit 0
fi

if [ -z "$ARTIST" ] || [ "$ARTIST" = "unknown artist" ] || [[ "$TITLE" == http* ]]; then
    CLEAN_TITLE=$(echo "$TITLE" | sed 's/http:\/\///g; s/https:\/\///g')
    echo "RADIO:$CLEAN_TITLE"
else
    echo "$ARTIST - $TITLE"
fi
