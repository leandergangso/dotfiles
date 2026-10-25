---@type vim.lsp.Config
return {
	disabled = false,
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "bash", "zsh" },
	root_markers = { ".git" },
}
