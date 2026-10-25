---@type vim.lsp.Config
return {
	disabled = true,
	cmd = { "htmx-lsp" },
	filetypes = {
		"html",
		"templ",
		"gohtml",
		"tmpl",
	},
	root_markers = { ".git" },
}
