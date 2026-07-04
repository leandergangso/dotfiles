vim.filetype.add({
	extension = {
		dockerfile = "dockerfile",
		containerfile = "dockerfile",
	},
	filename = {
		["Dockerfile"] = "dockerfile",
		["Containerfile"] = "dockerfile",
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
