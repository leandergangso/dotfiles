---@type vim.lsp.Config
return {
	disabled = false,
	cmd = { "taplo", "lsp", "stdio" },
	filetypes = { "toml" },
	root_markers = { ".git" },
}
