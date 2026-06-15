return {
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "bash", "zsh" },
	root_markers = { ".git" },
	settings = {
		bashIde = {
			-- Ensures the LSP looks for your system's shellcheck binary
			shellcheckPath = "shellcheck",
		},
	},
}
