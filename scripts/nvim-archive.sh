#!/usr/bin/env bash

set -euo pipefail

timestamp="$(date +%Y%m%d-%H%M%S)"
archive="${1:-nvim-offline-${timestamp}.tar.gz}"
archive_path="$PWD/$archive"

paths=(
  .config/nvim
  .local/share/nvim
  .local/state/nvim
)

selected=()
for path in "${paths[@]}"; do
  if [ -e "$HOME/$path" ]; then
    selected+=("$path")
  fi
done

if [ "${#selected[@]}" -eq 0 ]; then
  echo "No Neovim directories found under $HOME." >&2
  exit 1
fi

echo "Archiving:"
for path in "${selected[@]}"; do
  echo "  $HOME/$path"
done

tar -C "$HOME" -czf "$archive_path" "${selected[@]}"
echo "Created archive at $archive_path"
