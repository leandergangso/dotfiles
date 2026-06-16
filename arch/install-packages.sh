#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OFFICIAL_FILE="$ROOT/arch/packages/pacman.txt"
AUR_FILE="$ROOT/arch/packages/aur.txt"

clean_list() {
  awk '!/^[[:space:]]*(#|$)/' "$1" | sort -u
}

if [[ ! -f /etc/arch-release ]]; then
  echo "This installer only supports Arch Linux." >&2
  exit 1
fi

if [[ -f "$OFFICIAL_FILE" ]]; then
  mapfile -t official_packages < <(clean_list "$OFFICIAL_FILE")
  if (( ${#official_packages[@]} )); then
    echo "Installing official packages..."
    sudo pacman -S --needed -- "${official_packages[@]}"
  fi
fi

if [[ -s "$AUR_FILE" ]]; then
  if ! command -v yay >/dev/null 2>&1; then
    "$ROOT/arch/setup-yay.sh"
  fi

  mapfile -t aur_packages < <(clean_list "$AUR_FILE")
  if (( ${#aur_packages[@]} )); then
    echo "Installing AUR packages..."
    yay -S --needed -- "${aur_packages[@]}"
  fi
fi
