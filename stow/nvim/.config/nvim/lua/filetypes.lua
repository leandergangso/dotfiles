vim.filetype.add({
	pattern = {
		-- Dockerfile variations
		["[Dd]ockerfile.*"] = "dockerfile",
		["[Cc]ontainerfile.*"] = "dockerfile",

		-- Docker Compose, Podman Compose, and OCI Standard Compose files
		[".*docker%-compose.*%.yaml"] = "yaml",
		[".*docker%-compose.*%.yml"] = "yaml",
		[".*podman%-compose.*%.yaml"] = "yaml",
		[".*podman%-compose.*%.yml"] = "yaml",
		[".*compose.*%.yaml"] = "yaml",
		[".*compose.*%.yml"] = "yaml",
	},
})

vim.filetype.add({
	pattern = {
		[".*%.service"] = "systemd",
		[".*%.timer"] = "systemd",
		[".*%.target"] = "systemd",
		[".*%.mount"] = "systemd",
		[".*%.socket"] = "systemd",
		[".*%.path"] = "systemd",
	},
})

vim.filetype.add({ pattern = { [".*%.env.*"] = "env" } })

vim.filetype.add({ extension = { mjml = "html" } })

--vim.filetype.add({ extension = { templ = "templ" } })
