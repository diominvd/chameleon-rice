#!/bin/bash

show_help() {
  echo "Usage: $(basename "$0") [options]"
  echo "Options: -t (sort by time), -s (sort by size), -h (help)"
}

SORT_BY="time"
while getopts "tsh" opt; do
  case "$opt" in
    t) SORT_BY="time" ;;
    s) SORT_BY="size" ;;
    h) show_help; exit 0 ;;
    *) show_help; exit 1 ;;
  esac
done

for cmd in expac numfmt column; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "Error: $cmd is not installed."
    read -p "Press Enter to exit..."
    exit 1
  fi
done

mapfile -t PKGS < <(pacman -Qeq)
if [ ${#PKGS[@]} -eq 0 ]; then
  echo "No explicitly installed packages found."
  read -p "Press Enter to exit..."
  exit 0
fi

DATA=$(expac --timefmt='%Y-%m-%d %H:%M:%S' '%l\t%m\t%n' -Q "${PKGS[@]}")

if [ "$SORT_BY" == "time" ]; then
  SORTED=$(echo "$DATA" | sort)
else
  SORTED=$(echo "$DATA" | sort -k2 -n)
fi

{
  echo -e "DATE\tTIME\tSIZE\tPACKAGE"
  echo "$SORTED" | while read -r date time size name; do
    readable_size=$(numfmt --to=iec-i --suffix=B "$size")
    echo -e "$date\t$time\t$readable_size\t$name"
  done
} | column -t -s $'\t'

echo ""
read -p "Press Enter to close..."
