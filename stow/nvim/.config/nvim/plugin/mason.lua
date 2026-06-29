vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
}, {
	load = function(plugin)
		local opts = { desc = "[M]ason", silent = true }

		vim.keymap.set("n", "<leader>M", function()
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

			vim.cmd("Mason")

			-- rebind so future hits just the command
			vim.keymap.set("n", "<leader>M", "<cmd>Mason<CR>", opts)
		end, opts)
	end,
})
