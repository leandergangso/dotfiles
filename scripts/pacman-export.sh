#!/usr/bin/env bash

set -euo pipefail

[[ -f /etc/arch-release ]] || { echo "This generator only supports Arch Linux." >&2; exit 1; }

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACMAN_FILE="$ROOT/pacman.txt"

mkdir -p "$(dirname "$PACMAN_FILE")"

echo "Generating $PACMAN_FILE from explicitly installed packages..."

{
    echo "# Generated on $(date -u +"%Y-%m-%d %H:%M:%S UTC")"
    pacman -Qqe
} > "$PACMAN_FILE"

echo "Successfully updated $PACMAN_FILE with $(($(wc -l < "$PACMAN_FILE") - 1)) packages."
