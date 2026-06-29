vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
}, {
	load = function(plugin)
		vim.api.nvim_create_autocmd("BufRead", {
			once = true,
			callback = function()
				vim.cmd.packadd(plugin.spec.name)

				require("gitsigns").setup({
					signs = {
						add = { text = "+" },
						change = { text = "~" },
						delete = { text = "_" },
						topdelete = { text = "‾" },
						changedelete = { text = "~" },
					},
				})
			end,
		})
	end,
})

-- requires in options.lua: vim.opt.signcolumn = "yes"
