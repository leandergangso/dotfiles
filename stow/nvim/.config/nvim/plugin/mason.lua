vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
}, {
	load = function(plugin)
		vim.schedule(function()
			vim.cmd.packadd(plugin.spec.name)

			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			vim.keymap.set("n", "<leader>M", "<cmd>Mason<CR>", { desc = "[M]ason", silent = true })
		end)
	end,
})
