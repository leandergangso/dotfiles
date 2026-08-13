---@type vim.lsp.Config
return {
	cmd = { "emmet-ls", "--stdio" },
	filetypes = {
		"css",
		"scss",
		"sass",
		"html",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"svelte",
		"templ",
	},
	root_markers = { "package.json", ".git" },
}
