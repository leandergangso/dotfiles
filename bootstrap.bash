#!/usr/bin/env bash

set -e

# Distro check
if [ ! -f /etc/arch-release ]; then
    echo "Arch Linux is required for this bootstraping."
    exit 0
fi

# Install Ansible if missing
if ! command -v ansible &>/dev/null; then
  echo "Installing Ansible..."
  sudo pacman -Sy --noconfirm ansible
fi

# Clone or update your ansible setup repo
REPO_URL="https://github.com/leandergangso/dotfiles.git"
DIR="$HOME/.dotfiles"

if [ -d "$DIR" ]; then
  cd "$DIR"
  git pull
else
  git clone "$REPO_URL" "$DIR"
  cd "$DIR"
fi

# Run the playbook
ansible-playbook -i localhost, -c local playbook.yaml
