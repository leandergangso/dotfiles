#!/usr/bin/env bash

set -euo pipefail

timestamp="$(date +%Y%m%d-%H%M%S)"
archive="${1:-nvim-offline-${timestamp}.tar.gz}"
archive_path="$PWD/$archive"
staging_dir="$(mktemp -d)"
trap 'rm -rf "$staging_dir"' EXIT

paths=(
  .config/nvim
  .local/share/nvim
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
  source_path="$HOME/$path"
  staged_path="$staging_dir/$path"

  if [ -L "$source_path" ]; then
    echo "  $source_path -> $(readlink -f "$source_path")"
  else
    echo "  $source_path"
  fi

  if [ "$path" = ".config/nvim" ] && [ -L "$source_path" ]; then
    mkdir -p "$staged_path"
    cp -a "$source_path/." "$staged_path/"
  else
    mkdir -p "$(dirname "$staged_path")"
    cp -a "$source_path" "$staged_path"
  fi
done

tar -C "$staging_dir" -czf "$archive_path" "${selected[@]}"
echo "Created archive at $archive_path"
