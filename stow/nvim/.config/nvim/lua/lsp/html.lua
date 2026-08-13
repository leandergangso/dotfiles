---@type vim.lsp.Config
return {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = {
		"css",
		"scss",
		"sass",
		"html",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		--"svelte",
		"templ",
	},
	root_markers = { ".git" },
}
