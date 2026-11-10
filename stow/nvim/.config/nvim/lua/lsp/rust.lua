---@type vim.lsp.Config
return {
	disabled = false,
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { "Cargo.toml", "Cargo.lock", "rust-project.json", ".git" },
	settings = {
		["rust-analyzer"] = {
			checkOnSave = true,
			check = {
				command = "clippy",
			},
			cargo = {
				allFeatures = true,
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
			completion = {
				autoimport = {
					enable = true,
				},
				postfix = {
					enable = true,
				},
			},
			diagnostics = {
				enable = true,
			},
		},
	},
}
