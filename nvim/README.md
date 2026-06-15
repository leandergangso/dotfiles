# Personal Neovim config

![vim meme](hacks/vim-neo.jpg)

## Prerequisite

- Neovim installed
- Native toolchain and LSPs on `$PATH` via `nix profile install .#editor-tools`
- [Nerd Font](https://www.nerdfonts.com) (using: JetBrainsMono Nerd Font)
    - Download font you want
    - exec: `mv JetBrainsFont/JetBrains* ~/.local/share/fonts/`
    - specify font name in terminal settings (see `fc-list` for font names)

## Setup

- Make and CD into: `~/.config/nvim`
- Clone this repo: `git clone {URL}`
- Install editor tools: `nix profile install .#editor-tools`
- Open Neovim with: `nvim`
- Plugin state is tracked in `nvim-pack-lock.json`
- Update plugins with `:lua vim.pack.update()`
