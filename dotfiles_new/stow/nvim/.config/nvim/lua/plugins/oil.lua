return {
	"stevearc/oil.nvim",
	dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
	lazy = false,
	opts = {
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
	},
}
