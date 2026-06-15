vim.pack.add({
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
})

require("todo-comments").setup({
	signs = true,
	merge_keywords = true,
	keywords = {
		NOTE = { color = "hint" },
		TODO = { color = "info" },
		WARN = { color = "warning", alt = { "BUG" } },
		FIX = { color = "error", alt = { "DEL" } },
		TEST = { color = "test" },
		PERF = {},
	},
})

vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "[S]earch [T]odo" })
