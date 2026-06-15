# LSP Configurations

Each `lsp/<name>.lua` file returns a native Neovim LSP configuration and is automatically discovered and enables the LSP.

The language-server executable must be installed and available on `$PATH`.

## Template

```lua
-- lsp/example_ls.lua
return {
	cmd = { "example-language-server", "--stdio" },
	filetypes = { "example" },
	root_markers = {
		{ "example.json", "example.toml" },
		".git",
	},
	settings = {
		example = {
			feature = true,
		},
	},
	init_options = {},
}
```

The filename is the configuration name. For example, `lsp/gopls.lua`
defines the `gopls` configuration.

## Common Keys

| Key | Type | Purpose |
| --- | --- | --- |
| `cmd` | `string[]` or function | Command used to start the server. It must be an absolute path or available on `$PATH`. Shell syntax and `~` are not expanded. |
| `filetypes` | `string[]` | Buffer filetypes that may activate the server. Omitting it matches every filetype. |
| `root_markers` | `(string|string[])[]` | Files or directories used to locate the workspace root. Earlier entries have higher priority. |
| `root_dir` | `string` or function | Custom workspace-root selection. This overrides `root_markers`. |
| `settings` | table | Server-specific settings sent through `workspace/configuration`. Names and casing are defined by the server. |
| `init_options` | table | Server-specific options sent in the initial LSP request. |
| `capabilities` | table | Client capabilities advertised to the server. |
| `on_attach` | function or function list | Runs whenever the client attaches to a buffer. |
| `on_init` | function or function list | Runs after the server completes initialization. |
| `workspace_required` | boolean | Prevents activation when no workspace root can be found. Default: `false`. |

Nested root markers have equal priority:

```lua
root_markers = {
	{ "project.json", "project.toml" }, -- either marker
	".git",                             -- lower-priority fallback
}
```

Neovim searches upward for the first group, then moves to the next group only
if none of its markers are found.

## Advanced Keys

| Key | Purpose |
| --- | --- |
| `before_init` | Modify initialization parameters before starting the server. |
| `cmd_cwd` | Working directory used to launch `cmd`; independent of `root_dir`. |
| `cmd_env` | Environment variables passed to the server process. |
| `commands` | Handlers for commands requested by the server. |
| `detached` | Whether the server runs in a separate process group. |
| `exit_timeout` | Time in milliseconds before forcibly stopping the server, or a boolean policy. |
| `flags` | Experimental client behavior, such as change-notification debounce. |
| `get_language_id` | Converts a Neovim filetype into the server's language identifier. |
| `handlers` | Overrides handlers for specific LSP methods. |
| `offset_encoding` | Explicit server position encoding: `utf-8`, `utf-16`, or `utf-32`. |
| `on_error` | Callback for client-operation errors. |
| `on_exit` | Callback invoked when the server process exits. |
| `reuse_client` | Determines whether an existing client can serve another buffer. |
| `trace` | LSP protocol tracing: `off`, `messages`, or `verbose`. |
| `workspace_folders` | Explicit workspace folders supplied during initialization. |

Avoid setting advanced keys unless the server requires them.

## Server-Specific Values

Neovim validates the general configuration shape, but the contents of
`settings` and `init_options` are defined by each language server. Consult the
server's documentation for those values.

## Inspecting and Debugging

```vim
:checkhealth vim.lsp
:lua =vim.lsp.config.gopls
:lua =vim.lsp.get_clients({ bufnr = 0 })
:LspInfo
```

Relevant help:

```vim
:help lsp-config
:help vim.lsp.Config
:help vim.lsp.ClientConfig
:help lsp-root_markers
```
