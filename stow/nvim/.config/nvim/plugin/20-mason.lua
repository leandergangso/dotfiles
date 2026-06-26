vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
})

vim.schedule(function()
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
end)

vim.keymap.set("n", "<leader>M", "<cmd>Mason<CR>", { desc = "[M]ason", silent = true })
