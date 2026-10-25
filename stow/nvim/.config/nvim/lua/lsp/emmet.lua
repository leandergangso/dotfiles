---@type vim.lsp.Config
return {
	disabled = false,
	cmd = { "emmet-language-server", "--stdio" },
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
