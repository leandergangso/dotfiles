---@type vim.lsp.Config
return {
	disabled = false,
	cmd = { "tofu-ls", "serve" },
	filetypes = { "tofu", "terraform", "tf", "terraform-vars" },
	root_markers = { ".git", ".terraform" },
}
