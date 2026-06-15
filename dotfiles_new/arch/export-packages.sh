#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGE_DIR="$ROOT/arch/packages"
BACKUP_ROOT="$ROOT/arch/backups"

mkdir -p "$PACKAGE_DIR"

if [[ -f "$PACKAGE_DIR/official.txt" || -f "$PACKAGE_DIR/aur.txt" ]]; then
  mkdir -p "$BACKUP_ROOT"
  backup_dir="$(mktemp -d "$BACKUP_ROOT/$(date +%Y%m%d-%H%M%S).XXXXXX")"

  for manifest in official.txt aur.txt; do
    if [[ -f "$PACKAGE_DIR/$manifest" ]]; then
      cp -- "$PACKAGE_DIR/$manifest" "$backup_dir/$manifest"
    fi
  done

  echo "Backed up existing manifests to:"
  echo "  ${backup_dir#"$ROOT/"}"
fi

pacman -Qqen | sort > "$PACKAGE_DIR/official.txt"
pacman -Qqem | awk '$0 != "yay"' | sort > "$PACKAGE_DIR/aur.txt"

echo "Updated package manifests:"
echo "  arch/packages/official.txt"
echo "  arch/packages/aur.txt"
