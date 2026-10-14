---@type vim.lsp.Config
return {
	disabled = true,
	cmd = { "hyprls" },
	filetypes = { "hyprlang" },
	root_markers = {
		"hyprland.lua",
		"hyprland.conf",
		".git",
	},
}
