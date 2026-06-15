# Neovim

![vim meme](hacks/vim-neo.jpg)

This config is linked to `~/.config/nvim` by GNU Stow from the dotfiles
repository.

## Runtime dependencies

Language servers and formatters are installed by the repository's Nix flake,
not by Neovim:

```bash
nix profile install path/to/dotfiles
```

The flake supplies Neovim, LSP servers for Lua, Go, CSS, Svelte, Tailwind,
and TypeScript, plus Prettier, StyLua, and the Typst preview runtime. Go
formatting uses `gofmt`, which is provided by Go itself.
