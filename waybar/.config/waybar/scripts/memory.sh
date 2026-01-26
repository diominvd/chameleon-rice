#!/usr/bin/env bash

# Memory status script for Waybar with top process tooltip

Signal() {
    pkill -RTMIN+10 waybar 2>/dev/null
}

get_memory_info() {
    local mem_line total available used_gb total_gb percent

    mem_line=$(free -m | awk '/^Mem:/ {print $2" "$7}')
    if [ -z "$mem_line" ]; then
        echo '{"text":"󰍛 N/A","tooltip":"Unable to read memory info","class":"unavailable"}'
        exit 0
    fi

    read -r total available <<< "$mem_line"

    if [ -z "$total" ] || [ "$total" -eq 0 ]; then
        percent=0
    else
        percent=$(awk -v t="$total" -v a="$available" 'BEGIN { printf "%.0f", ((t - a) / t) * 100 }')
    fi

    used_gb=$(awk -v t="$total" -v a="$available" 'BEGIN { printf "%.1f", (t - a) / 1024 }')
    total_gb=$(awk -v t="$total" 'BEGIN { printf "%.1f", t / 1024 }')

    local class="normal"
    if [ "$percent" -ge 90 ]; then
        class="critical"
    elif [ "$percent" -ge 75 ]; then
        class="warning"
    fi

    mapfile -t processes < <(ps --no-headers -eo pid,comm,%mem --sort=-%mem | head -n 3)
    local tooltip="RAM: ${used_gb}/${total_gb} GiB (${percent}%)\\nTop processes:"

    if [ "${#processes[@]}" -eq 0 ]; then
        tooltip+="\\n• (no data)"
    else
        local entry pid comm mem
        for entry in "${processes[@]}"; do
            read -r pid comm mem <<< "$entry"
            tooltip+="\\n• ${comm} (${mem}% | PID ${pid})"
        done
    fi

    echo "{\"text\":\"󰍛 ${percent}%\",\"tooltip\":\"${tooltip}\",\"class\":\"${class}\"}"
}

case "$1" in
    --refresh)
        Signal
        ;;
    *)
        get_memory_info
        ;;
esac
