---@type vim.lsp.Config
return {
	disabled = false,
	cmd = { "zls" },
	filetypes = { "zig", "zir" },
	root_markers = { "build.zig", "zls.json", ".git" },
}
