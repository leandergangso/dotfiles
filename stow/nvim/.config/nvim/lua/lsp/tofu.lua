---@type vim.lsp.Config
return {
	cmd = { "tofu-ls", "serve" },
	filetypes = { "tofu", "terraform", "tf", "terraform-vars" },
	root_markers = { ".git", ".terraform" },
}
