vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/stevearc/oil.nvim",
})

require("oil").setup({
	float = {
		padding = 2,
		border = "rounded",
	},
	confirmation = {
		border = "rounded",
	},
	view_options = {
		show_hidden = false,
	},
})
