---@type vim.lsp.Config
return {
	disabled = true,
	cmd = { "templ", "lsp" },
	filetypes = { "templ" },
	root_markers = { ".git", "go.mod", "package.json" },
}
