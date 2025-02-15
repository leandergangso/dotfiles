# Dotfiles

To use only certain dotfiles run:

`stow {name} --adopt`

To include all dotfiles run:

`find . -mindepth 1 -maxdepth 1 -type d -exec stow {} --adopt \;`

