# Neovim Special Directories

Neovim uses two related directory systems:

1. Standard paths returned by `stdpath()`, used to store configuration, data,
   state, caches, and logs.
2. Special directories on `'runtimepath'`, used to discover and load
   configuration, plugins, filetype settings, LSP configurations, and other
   runtime files.

## Standard Paths

These locations follow the XDG Base Directory specification on Linux.
`$NVIM_APPNAME` replaces the default `nvim` directory name when set.

| `stdpath()` key | Default Linux location | Usage | Example |
|---|---|---|---|
| `config` | `~/.config/nvim` | User configuration | `init.lua` |
| `data` | `~/.local/share/nvim` | Persistent user and plugin data | `site/pack/`, installed plugins |
| `state` | `~/.local/state/nvim` | Persistent editor state | ShaDa, swap, undo, backup, views |
| `cache` | `~/.cache/nvim` | Regenerable cached data | Plugin caches |
| `run` | `$XDG_RUNTIME_DIR` | Short-lived local runtime data | Sockets and named pipes |
| `log` | `~/.local/state/nvim` | Logs; currently aliases `state` | `nvim.log` |
| `config_dirs` | `/etc/xdg/nvim` | Additional system configuration | Administrator configuration |
| `data_dirs` | `/usr/local/share/nvim`, `/usr/share/nvim`, etc. | Additional system data | System-installed runtime files |

Inspect a path from Neovim:

```vim
:echo stdpath('config')
:echo stdpath('data')
:echo stdpath('state')
```

From Lua:

```lua
local config_dir = vim.fn.stdpath("config")
local data_dir = vim.fn.stdpath("data")
```

## Runtime Directories

The following directories are special when placed under a directory in
`'runtimepath'`. For personal configuration, that usually means
`~/.config/nvim/`.

| Path | Usage | Loading behavior | Example |
|---|---|---|---|
| `after/` | Override or extend earlier runtime files | Searched after normal runtime directories | `after/ftplugin/go.lua` |
| `autoload/` | Vimscript autoload functions | Loaded when an autoload function is called | `autoload/project/files.vim` |
| `colors/` | Colorschemes | Loaded by `:colorscheme` | `colors/mytheme.lua` |
| `compiler/` | Compiler and error-format definitions | Loaded by `:compiler` | `compiler/golang.lua` |
| `doc/` | Help documentation | Read by `:help`; requires generated tags | `doc/myplugin.txt` |
| `ftdetect/` | Additional filetype detection rules | Loaded during filetype initialization | `ftdetect/templ.lua` |
| `ftplugin/` | Filetype-specific options and mappings | Loaded when a buffer's filetype is set | `ftplugin/go.lua` |
| `indent/` | Filetype indentation logic | Loaded when filetype indentation is enabled | `indent/myformat.lua` |
| `keymap/` | Language input mappings | Loaded through the `'keymap'` option | `keymap/norwegian_utf-8.vim` |
| `lang/` | Translated menus | Loaded according to language settings | `lang/menu_nb_no.utf-8.vim` |
| `lsp/` | LSP client configurations | Resolved by `vim.lsp.config()` | `lsp/gopls.lua` |
| `lua/` | Reusable Lua modules | Loaded on demand with `require()` | `lua/config/options.lua` |
| `pack/` | Native packages | `start/` loads automatically; `opt/` uses `:packadd` | `pack/core/opt/telescope.nvim/` |
| `parser/` | Tree-sitter parser libraries | Loaded when a parser is requested | `parser/lua.so` |
| `plugin/` | Startup scripts | Automatically sourced during startup | `plugin/00-theme.lua` |
| `queries/` | Tree-sitter queries | Loaded by Tree-sitter features | `queries/lua/highlights.scm` |
| `rplugin/` | Remote plugins | Registered and loaded through remote hosts | `rplugin/python/tool.py` |
| `spell/` | Spell dictionaries and additions | Loaded according to `'spelllang'` | `spell/en.utf-8.add` |
| `syntax/` | Regex-based syntax definitions | Loaded when syntax is enabled | `syntax/myformat.vim` |
| `tutor/` | Interactive tutorial files | Loaded by `:Tutor` | `tutor/my-tutorial.tutor` |

Special files at the root of a runtime directory:

| File | Usage |
|---|---|
| `filetype.lua` | Filetype detection rules |
| `menu.vim` | GUI menu definitions |

## Recommended Personal Layout

```text
~/.config/nvim/
|-- init.lua
|-- lua/
|   `-- config/
|       |-- options.lua
|       |-- keymaps.lua
|       `-- autocmds.lua
|-- plugin/
|   |-- 00-theme.lua
|   `-- telescope.lua
|-- ftplugin/
|   |-- go.lua
|   `-- typst.lua
|-- lsp/
|   |-- gopls.lua
|   `-- lua_ls.lua
`-- after/
    |-- ftplugin/
    `-- queries/
```

Keep `init.lua` small and use it to load ordinary modules:

```lua
require("config.options")
require("config.keymaps")
require("config.autocmds")
```

`require("config.options")` resolves
`lua/config/options.lua` from `'runtimepath'`.

Use the special directories when their automatic loading semantics match the
configuration. Use `lua/` for reusable modules and general configuration that
you explicitly load.

## Common Examples

### Filetype Configuration

```lua
-- ftplugin/go.lua
vim.opt_local.expandtab = false
vim.opt_local.tabstop = 4

vim.keymap.set("n", "<leader>r", "<cmd>GoRun<CR>", {
    buffer = true,
    desc = "Run Go program",
})
```

### LSP Configuration

```lua
-- lsp/gopls.lua
return {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
}
```

Enable it from a general configuration module:

```lua
vim.lsp.enable("gopls")
```

### Runtime Override

```lua
-- after/ftplugin/markdown.lua
vim.opt_local.textwidth = 80
vim.opt_local.conceallevel = 0
```

### Startup Plugin File

Files in each `plugin/` directory are sourced alphabetically. Prefix a filename
only when startup order matters:

```lua
-- plugin/00-theme.lua
vim.pack.add({
    {
        src = "https://github.com/catppuccin/nvim",
        name = "catppuccin",
    },
})

vim.cmd.colorscheme("catppuccin")
```

Avoid relying on ordering between different directories in `'runtimepath'`.
Use explicit dependencies or `require()` when one piece of configuration must
run before another.

## Relevant Help

```vim
:help standard-path
:help stdpath()
:help runtimepath
:help load-plugins
:help lua-guide-config
:help lua-guide-modules
:help lsp-config
:help after-directory
:help packages
```
