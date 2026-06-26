vim.pack.add({
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
}, {
	load = function(plugin)
		vim.api.nvim_create_autocmd("UIEnter", {
			once = true,
			callback = function()
				vim.cmd.packadd(plugin.spec.name)
				require("lualine").setup({
					options = {
						theme = "auto",
						globalstatus = true,
						disabled_filetypes = { "alpha", "oil" },
					},
					sections = {
						lualine_a = { "mode" },
						lualine_b = { "branch", "diff" },
						lualine_c = {
							{ "filename", path = 1 },
							"diagnostics",
						},
						lualine_x = { "filetype" },
						lualine_y = { "progress" },
						lualine_z = { "location" },
					},
				})
			end,
		})
	end,
})
