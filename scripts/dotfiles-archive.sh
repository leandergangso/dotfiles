#!/usr/bin/env bash

set -euo pipefail

archive="dotfiles-$(date +%Y%m%d-%H%M%S).tar.gz"

echo "Creating $archive (excluding .git)..."

touch "$HOME"/dotfiles/"$archive"
tar --exclude="$archive" --exclude='.git' -czf "$archive" -C "$HOME" dotfiles/

echo "Archive created successfully."
