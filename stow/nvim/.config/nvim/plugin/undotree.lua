vim.pack.add({
	{ src = "https://github.com/mbbill/undotree" },
}, {
	load = function(plugin)
		vim.g.undotree_SetFocusWhenToggle = 1
		vim.g.undotree_SplitWidth = 35

		vim.keymap.set("n", "<leader>u", function()
			vim.cmd.packadd(plugin.spec.name)
			vim.cmd.UndotreeToggle()
		end, { desc = "[U]ndo Tree", silent = true })
	end,
})
