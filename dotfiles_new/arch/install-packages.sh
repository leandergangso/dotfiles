#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

OFFICIAL_FILE="$ROOT/arch/packages/official.txt"
AUR_FILE="$ROOT/arch/packages/aur.txt"

clean_list() {
  awk '!/^[[:space:]]*(#|$)/' "$1" | sort -u
}

if [[ ! -f /etc/arch-release ]]; then
  echo "This installer only supports Arch Linux." >&2
  exit 1
fi

echo "Installing official packages..."
mapfile -t official_packages < <(clean_list "$OFFICIAL_FILE")
sudo pacman -Syu --needed -- "${official_packages[@]}"

if [[ -s "$AUR_FILE" ]]; then
  if ! command -v yay >/dev/null 2>&1; then
    "$ROOT/arch/setup-yay.sh"
  fi

  echo "Installing AUR packages..."
  mapfile -t aur_packages < <(clean_list "$AUR_FILE")
  yay -S --needed -- "${aur_packages[@]}"
fi
