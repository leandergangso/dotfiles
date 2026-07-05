---@type vim.lsp.Config
return {
	disabled = true,
	cmd = { "nil" },
	filetypes = { "nix" },
	root_markers = {
		"flake.nix",
		".git",
	},
}
