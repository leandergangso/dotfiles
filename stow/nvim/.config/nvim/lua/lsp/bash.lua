---@type vim.lsp.Config
return {
	disabled = false,
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "bash" },
	root_markers = { ".git" },
}
