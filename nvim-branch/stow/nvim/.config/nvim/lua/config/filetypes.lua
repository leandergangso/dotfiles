-- containerfile for dockerfile
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
