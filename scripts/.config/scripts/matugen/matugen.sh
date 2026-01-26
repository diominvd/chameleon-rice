#!/usr/bin/env bash

set -uo pipefail

# Enable logging to a file and show output in terminal
LOG_FILE="$HOME/.cache/matugen_debug.log"
exec > >(tee -a "$LOG_FILE") 2>&1

WALLPAPER="${1:-}"
if [[ -z "$WALLPAPER" || ! -f "$WALLPAPER" ]]; then
    echo "> ERROR: No valid wallpaper provided or file does not exist."
    notify-send -u critical "Matugen Error" "No valid wallpaper provided"
    exit 1
fi

echo "> Setting wallpaper: $WALLPAPER"
swww img "$WALLPAPER" \
    --transition-type grow \
    --transition-pos center \
    --transition-step 255 \
    --transition-duration 2 \
    --transition-fps 120 \
    --resize crop || echo "SWWW error suppressed"

echo "> Analyzing wallpaper saturation..."
SATURATION=$(magick "$WALLPAPER" -colorspace HSL -format "%[fx:mean.g]" info:)
THRESHOLD=0.1

if (( $(echo "$SATURATION < $THRESHOLD" | bc -l) )); then
    echo "> [!] B&W Mode: Generating neutral palette"
    MATUGEN_CMD="color hex 808080"
else
    echo "> [+] Color Mode: Generating palette from image"
    MATUGEN_CMD="image $WALLPAPER"
fi

echo "> Generating palette with Matugen"
matugen $MATUGEN_CMD --mode dark --type scheme-content || {
    echo "ERROR: Matugen failed to generate palette"
    notify-send -u critical "Matugen" "Failed to generate Material You palette"
    exit 1
}

# Reload Waybar
echo "> Reloading Waybar"
if pgrep -x waybar >/dev/null; then
    killall -SIGUSR2 waybar
fi

# Update GTK
echo "> Updating GTK settings"
gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
killall xdg-desktop-portal-gtk || true
killall xdg-desktop-portal || true

# Reload Polkit-GNOME
echo "> Reloading Polkit"
if pgrep -f polkit-gnome-authentication-agent-1 >/dev/null; then
    killall polkit-gnome-authentication-agent-1
    sleep 0.5
fi
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Kitty + shell reload
echo "> Reloading Kitty and Shell"
if pgrep -x kitty >/dev/null; then
    killall -SIGUSR1 kitty || true
fi

# Mako
echo "> Reloading Mako"
if pgrep -x mako >/dev/null; then
    makoctl reload || true
fi

notify-send "Matugen" "Colors updated"

exit 0
