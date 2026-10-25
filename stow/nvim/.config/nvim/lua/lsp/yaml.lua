---@type vim.lsp.Config
return {
	disabled = false,
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml" },
	root_markers = { ".git" },
}
