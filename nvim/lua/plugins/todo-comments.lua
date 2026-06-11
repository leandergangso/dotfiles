return {
	"folke/todo-comments.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
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
	end,
}
