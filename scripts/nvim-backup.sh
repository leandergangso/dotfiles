#!/usr/bin/env bash

set -euo pipefail

timestamp="$(date +%Y%m%d-%H%M%S)"
backup_root="$HOME/.local/state/nvim-backups/$timestamp"

paths=(
  .config/nvim
  .local/share/nvim
  .local/state/nvim
  .cache/nvim
)

mkdir -p "$backup_root"

for path in "${paths[@]}"; do
  source_path="$HOME/$path"

  if [ ! -e "$source_path" ]; then
    echo "Skipping missing path: $source_path"
    continue
  fi

  target_path="$backup_root/$path"
  mkdir -p "$(dirname "$target_path")"
  mv -- "$source_path" "$target_path"
  echo "Moved $source_path to $target_path"
done

echo "Created Neovim backup at $backup_root"
