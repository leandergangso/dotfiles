vim.pack.add({
	{ src = "https://github.com/windwp/nvim-autopairs" },
}, {
	load = function(plugin)
		vim.api.nvim_create_autocmd("InsertEnter", {
			once = true,
			callback = function()
				vim.cmd.packadd(plugin.spec.name)
				require("nvim-autopairs").setup({})
			end,
		})
	end,
})
