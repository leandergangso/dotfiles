return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork" },
	root_markers = { "go.work", "go.mod", ".git" },
	settings = {
		gopls = {
			gofumpt = true,
			staticcheck = true,
			usePlaceholders = true,
			completeUnimported = true,
			analyses = {
				unusedparams = true,
				unusedwrite = true,
				nilness = true,
				shadow = false,
				ST1000 = false,
			},
		},
	},
}
