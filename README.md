# Dotfiles

Arch Linux dotfiles managed with GNU Stow.

```bash
git clone https://github.com/leandergangso/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
sudo pacman -S --needed go-task stow
```

Run `task` to inspect the available command list.  
The underlying `stow` and `arch/*.sh` scripts are still usable directly.

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
