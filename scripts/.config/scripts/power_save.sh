#!/usr/bin/env bash

PROFILE=$(powerprofilesctl get)
MONITOR="eDP-1" # Замени на свой, если отличается

if [ "$PROFILE" != "power-saver" ]; then
    powerprofilesctl set power-saver
    sudo supergfxctl -m Integrated
    
    hyprctl keyword monitor "$MONITOR,highres,auto,1,transform,0,vrr,0"
    
    if [ -f /sys/devices/system/cpu/intel_pstate/no_turbo ]; then
        echo "1" | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo > /dev/null
    fi
    
    brightnessctl set 30%
    notify-send -u low "Power Manager" "Eco Mode: 60Hz Active"
else
    powerprofilesctl set balanced
    
    hyprctl keyword monitor "$MONITOR,highrr,auto,1"
    
    if [ -f /sys/devices/system/cpu/intel_pstate/no_turbo ]; then
        echo "0" | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo > /dev/null
    fi
    
    brightnessctl set 80%
    notify-send "Power Manager" "Performance Mode: High Refresh Rate"
fi

pkill -RTMIN+8 waybar
