---@type vim.lsp.Config
return {
	disabled = false,
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_markers = { ".git" },
}
