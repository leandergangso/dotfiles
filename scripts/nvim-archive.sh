#!/usr/bin/env bash

set -euo pipefail

# 1. Archive filename (Defaults to local directory)
archive="${1:-nvim-offline-$(date +%Y%m%d-%H%M%S).tar.gz}"

# 2. Paths to grab (relative to $HOME)
paths=(
    dotfiles/stow/nvim/.config/nvim
    .local/share/nvim
)

# 3. Filter existing paths
to_archive=()
for path in "${paths[@]}"; do
    if [ -e "$HOME/$path" ]; then
        to_archive+=("$path")
    fi
done

if [ "${#to_archive[@]}" -eq 0 ]; then
    echo "No Neovim directories found." >&2
    exit 1
fi

# 4. Create the archive
echo "Creating $archive in $PWD..."
tar -C "$HOME" -czf "$archive" "${to_archive[@]}"

echo "Done!"
