---@type vim.lsp.Config
return {
	disabled = false,
	cmd = { "ols" },
	filetypes = { "odin" },
	root_markers = { "ols.json", ".git" },
}
