#!/usr/bin/env bash

PROFILE=$(powerprofilesctl get)

if [ "$PROFILE" != "power-saver" ]; then
    powerprofilesctl set power-saver
    supergfxctl -m Integrated
    [ -f /sys/devices/system/cpu/intel_pstate/no_turbo ] && echo "1" | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo > /dev/null
    brightnessctl set 30%
else
    powerprofilesctl set balanced
    [ -f /sys/devices/system/cpu/intel_pstate/no_turbo ] && echo "0" | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo > /dev/null
    brightnessctl set 80%
fi

pkill -RTMIN+8 waybar
