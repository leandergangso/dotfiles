---@type vim.lsp.Config
return {
	disabled = false,
	cmd = { "tsc", "--lsp", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	root_markers = {
		"tsconfig.json",
		"jsconfig.json",
		"package.json",
		".git",
	},
	settings = {
		typescript = {
			updateImportsOnFileMove = { enabled = "always" },
		},
	},
}
