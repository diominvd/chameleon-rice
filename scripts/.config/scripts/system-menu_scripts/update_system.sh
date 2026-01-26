#!/usr/bin/env bash

notify() {
    notify-send -a "System" -u "${2:-normal}" "System" "$1"
}

update_process() {
    TEMP_SCRIPT=$(mktemp)

    echo "#!/bin/bash" > "$TEMP_SCRIPT"
    echo "pacman -Syu --noconfirm" >> "$TEMP_SCRIPT"

    chmod +x "$TEMP_SCRIPT"

    if pkexec "$TEMP_SCRIPT"; then
        yay -Sua --noconfirm
        notify "All packages updated"
    else
        notify "Error during the update process" "critical"
    fi

    rm -f "$TEMP_SCRIPT"
}

# Запуск в фоне
update_process &
