vim.pack.add({
	"https://github.com/mbbill/undotree",
}, {
	load = function(plugin)
		vim.keymap.set("n", "<leader>u", function()
			vim.cmd.packadd(plugin.spec.name)
			vim.cmd.UndotreeToggle()
		end, { desc = "[U]ndo Tree" })
	end,
})
