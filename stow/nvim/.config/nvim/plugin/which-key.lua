vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim" },
}, {
	load = function(plugin)
		vim.api.nvim_create_autocmd("BufEnter", {
			once = true,
			callback = function()
				vim.cmd.packadd(plugin.spec.name)
				require("which-key").setup({
					delay = 1000,
					icons = {
						mappings = true,
						keys = {},
					},
				})
			end,
		})
	end,
})
