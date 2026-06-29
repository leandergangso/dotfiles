vim.pack.add({
	{ src = "https://github.com/mbbill/undotree" },
}, {
	load = function(plugin)
		local loaded = false

		vim.keymap.set("n", "<leader>u", function()
			if not loaded then
				vim.g.undotree_SetFocusWhenToggle = 1
				vim.g.undotree_SplitWidth = 35
				vim.cmd.packadd(plugin.spec.name)
				loaded = true
			end

			vim.cmd.UndotreeToggle()
		end, { desc = "[U]ndo Tree" })
	end,
})
