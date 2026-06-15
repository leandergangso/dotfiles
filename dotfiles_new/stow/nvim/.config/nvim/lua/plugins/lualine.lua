return {
	"nvim-lualine/lualine.nvim",
	dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
	lazy = false,
	opts = {
		options = {
			theme = "auto",
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff" },
			lualine_c = {
				{
					"filename",
					path = 1,
				},
			},
			lualine_x = { "encoding", "fileformat" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
}
