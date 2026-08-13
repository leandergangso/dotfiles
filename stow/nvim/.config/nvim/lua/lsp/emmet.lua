---@type vim.lsp.Config
return {
	cmd = { "emmet-ls", "--stdio" },
	filetypes = { "html", "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact", "templ" },
	root_markers = { "package.json", ".git" },
}
