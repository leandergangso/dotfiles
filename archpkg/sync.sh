#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

PACMAN_FILE="$ROOT/archpkg/pacman.txt"
AUR_FILE="$ROOT/archpkg/aur.txt"

clean_list() {
  grep -vE '^\s*#|^\s*$' "$1" | sort -u
}

echo "Installing pacman packages..."
if [[ -f "$PACMAN_FILE" ]]; then
  clean_list "$PACMAN_FILE" | sudo pacman -S --needed -
fi

echo "Installing AUR packages..."
if [[ -f "$AUR_FILE" ]]; then
  clean_list "$AUR_FILE" | yay -S --needed -
fi
