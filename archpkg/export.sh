#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "$ROOT/archpkg"

pacman -Qqen | sort > "$ROOT/archpkg/pacman.txt"
pacman -Qqem | sort > "$ROOT/archpkg/aur.txt"

echo "Updated package manifests:"
echo "  archpkg/pacman.txt"
echo "  archpkg/aur.txt"
