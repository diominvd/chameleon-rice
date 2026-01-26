#!/usr/bin/env bash

# GPU Temperature script for Waybar
# Supports NVIDIA GPUs using nvidia-smi

build_output() {
    local icon class temp gpu_name utilization memory power tooltip

    temp="$1"
    gpu_name="$2"
    utilization="$3"
    memory="$4"
    power="$5"

    if [ "$temp" -ge 90 ]; then
        icon="󰸇"
        class="critical"
    elif [ "$temp" -ge 80 ]; then
        icon="󰔏"
        class="warning"
    else
        icon="󰢮"
        class="normal"
    fi

    tooltip="<b>${gpu_name}</b>\nTemperature: ${temp}°C"

    [ -n "$utilization" ] && tooltip+="\nGPU Usage: ${utilization}%"
    [ -n "$memory" ] && tooltip+="\nMemory Usage: ${memory}%"
    [ -n "$power" ] && tooltip+="\nPower Draw: ${power}"

    echo "{\"text\":\"${icon} ${temp}°C\",\"tooltip\":\"${tooltip}\",\"class\":\"${class}\"}"
}

try_nvidia() {
    if ! command -v nvidia-smi >/dev/null 2>&1; then
        return 1
    fi

    local temp gpu_name gpu_utilization gpu_memory power_draw

    temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null)
    if [ -z "$temp" ] || ! [[ "$temp" =~ ^[0-9]+$ ]]; then
        return 1
    fi

    gpu_name=$(nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null)
    gpu_utilization=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null)
    gpu_memory=$(nvidia-smi --query-gpu=utilization.memory --format=csv,noheader,nounits 2>/dev/null)
    power_draw=$(nvidia-smi --query-gpu=power.draw --format=csv,noheader 2>/dev/null)

    build_output "$temp" "$gpu_name" "$gpu_utilization" "$gpu_memory" "$power_draw"
    return 0
}

try_sensors() {
    if ! command -v sensors >/dev/null 2>&1; then
        return 1
    fi

    local sensor_output temp
    sensor_output=$(sensors 2>/dev/null)
    if [ -z "$sensor_output" ]; then
        return 1
    fi

    temp=$(echo "$sensor_output" | awk '
        /amdgpu|radeon|GPU/ {in_block=1}
        in_block && /(edge|temp1|GPU Temperature)/ {
            if (match($0, /([0-9]+\.?[0-9]*)°C/, arr)) {
                print arr[1];
                exit 0;
            }
        }
        /^$/ {in_block=0}
    ')

    if [ -z "$temp" ]; then
        return 1
    fi

    temp=$(printf '%.0f' "$temp")
    build_output "$temp" "Integrated GPU" "" "" ""
    return 0
}

if try_nvidia; then
    exit 0
fi

if try_sensors; then
    exit 0
fi

echo '{"text":"","tooltip":"GPU telemetry unavailable","class":"hidden"}'
