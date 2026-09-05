#!/usr/bin/env bash

set -euo pipefail

[[ -f /etc/arch-release ]] || { echo "This installer only supports Arch Linux." >&2; exit 1; }

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACMAN_FILE="$ROOT/pacman.txt"

if [[ -f "$PACMAN_FILE" ]]; then
    mapfile -t pkgs < <(awk '!/^[[:space:]]*(#|$)/' "$PACMAN_FILE")

    if (( ${#pkgs[@]} )); then
        echo "Installing pacman packages..."
        sudo pacman -S --needed -- "${pkgs[@]}"
    fi
fi
