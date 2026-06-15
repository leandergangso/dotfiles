vim.pack.add({
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
}, {
	load = function(plugin)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "typst",
			once = true,
			callback = function()
				vim.cmd.packadd(plugin.spec.name)
				require("typst-preview").setup({
					follow_cursor = true,
					dependencies_bin = {
						tinymist = vim.fn.exepath("tinymist"),
						websocat = vim.fn.exepath("websocat"),
					},
				})
			end,
		})
	end,
})
