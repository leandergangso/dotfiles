---@type vim.lsp.Config
return {
	cmd = { "hyprls" },
	filetypes = { "hyprlang" },
	root_markers = {
		"hyprland.lua",
		"hyprland.conf",
		".git",
	},
}
