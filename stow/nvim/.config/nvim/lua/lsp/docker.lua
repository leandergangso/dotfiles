---@type vim.lsp.Config
return {
	cmd = { "docker-language-server", "start", "--stdio" },
	filetypes = {
		"dockerfile",
		"yaml",
	},
	root_markers = {
		"Dockerfile",
		"docker-compose.yml",
		"compose.yml",
		".git",
	},
}
