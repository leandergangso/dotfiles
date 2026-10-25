---@type vim.lsp.Config
return {
	disabled = false,
	cmd = { "systemd-lsp" },
	filetypes = { "systemd" },
	root_markers = { ".git" },
}
