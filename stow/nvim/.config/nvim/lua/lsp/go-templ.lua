---@type vim.lsp.Config
return {
	cmd = { "templ", "lsp" },
	filetypes = { "templ" },
	root_markers = { ".git", "go.mod", "package.json" },
}
