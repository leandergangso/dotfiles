#!/usr/bin/env bash

set -euo pipefail

if [[ ! -f /etc/arch-release ]]; then
  echo "This script only supports Arch Linux." >&2
  exit 1
fi

if command -v yay >/dev/null 2>&1; then
  echo "yay is already installed."
  exit 0
fi

if (( EUID == 0 )); then
  echo "Run this script as a regular user, not as root." >&2
  exit 1
fi

sudo pacman -S --needed git base-devel

build_dir="$(mktemp -d)"
trap 'rm -rf "$build_dir"' EXIT

git clone https://aur.archlinux.org/yay.git "$build_dir/yay"
(
  cd "$build_dir/yay"
  makepkg -si
)
