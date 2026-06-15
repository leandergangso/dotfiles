#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

PACMAN_FILE="$ROOT/archpkg/pacman.txt"
AUR_FILE="$ROOT/archpkg/aur.txt"

clean_list() {
  awk '!/^[[:space:]]*(#|$)/' "$1" | sort -u
}

if [[ ! -f /etc/arch-release ]]; then
  echo "This script only supports Arch Linux." >&2
  exit 1
fi

echo "Installing pacman packages..."
if [[ -f "$PACMAN_FILE" ]]; then
  mapfile -t pacman_packages < <(clean_list "$PACMAN_FILE")
  if (( ${#pacman_packages[@]} )); then
    sudo pacman -S --needed -- "${pacman_packages[@]}"
  fi
fi

echo "Installing AUR packages..."
if [[ -s "$AUR_FILE" ]]; then
  if ! command -v yay >/dev/null 2>&1; then
    echo "yay is required but not installed." >&2
    exit 1
  fi

  mapfile -t aur_packages < <(clean_list "$AUR_FILE")
  if (( ${#aur_packages[@]} )); then
    yay -S --needed -- "${aur_packages[@]}"
  fi
fi
