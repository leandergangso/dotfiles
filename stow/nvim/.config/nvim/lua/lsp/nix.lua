---@type vim.lsp.Config
return {
	disabled = false,
	cmd = { "nil" },
	filetypes = { "nix" },
	root_markers = {
		"flake.nix",
		".git",
	},
}
