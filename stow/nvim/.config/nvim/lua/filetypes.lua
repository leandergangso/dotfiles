vim.filetype.add({
	pattern = {
		-- Dockerfile
		["[Dd]ockerfile.*"] = "dockerfile",

		-- Docker Compose & Podman Compose
		[".*docker%-compose.*%.yaml"] = "yaml",
		[".*docker%-compose.*%.yml"] = "yaml",
		[".*podman%-compose.*%.yaml"] = "yaml",
		[".*podman%-compose.*%.yml"] = "yaml",
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

vim.filetype.add({
	pattern = {
		[".*%.env.*"] = "env",
	},
})
