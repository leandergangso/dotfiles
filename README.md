# Dotfiles

Arch Linux dotfiles managed with GNU Stow.

```bash
git clone https://github.com/leandergangso/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
sudo pacman -S --needed go-task stow
```

Run `task` to inspect the available command list.  
The underlying `stow` and `arch/*.sh` scripts are still usable directly.

## Hyprland

The Hyprland config lives in `stow/hyprland/.config/hypr/`, with
`hyprland.lua` as the Lua entry point and supporting modules under `conf/`.

It expects `waybar`, `wofi`, `mako`, `hyprlock`, and `hypridle` alongside
Hyprland itself, plus XWayland for older X11 apps. The keybindings are
intentionally close to the old i3 layout, so it should feel familiar if you
switch over.

The Wayland pieces are themed around Catppuccin Mocha, matching the rest of
the setup.

## Terminal

The terminal setup lives in `stow/kitty/.config/kitty/` and
`stow/zsh/.zshrc`, and is meant to be used together.

`kitty` is the preferred terminal, `zsh` is the shell config, and
`oh-my-posh` is an optional prompt enhancement that is enabled only when the
binary is available.

##  Neovim

![vim meme](vim-neo.jpg)

The Neovim config lives in `stow/nvim/.config/nvim/` and is managed by GNU
Stow, so you do not clone it into `~/.config/nvim` manually.

It uses Neovim's native package manager (`vim.pack`) for plugins, Mason for
editor tooling, and tree-sitter for syntax parsing. Mason-installed tools live
under `~/.local/share/nvim/mason/`. `tree-sitter-cli` is required because
`tree-sitter-manager.nvim` depends on it.

Update plugins from the dashboard quick actions or with `:lua vim.pack.update()`.

Run `task nvim:backup` to backup current Neovim setup, to test this config.
Run `task nvim:archive` to create a tarball for offline use.
