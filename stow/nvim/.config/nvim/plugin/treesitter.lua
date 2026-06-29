vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
})

require("treesitter-context").setup({
	enable = true,
	multiwindow = false,
	max_lines = 0,
	min_window_height = 0,
	line_numbers = true,
	multiline_threshold = 20,
	trim_scope = "outer",
	mode = "cursor",
	separator = nil,
	zindex = 20,
	on_attach = nil,
})

vim.pack.add({
	{ src = "https://github.com/romus204/tree-sitter-manager.nvim" },
}, {
	load = function(plugin)
		local opts = { desc = "[T]reesitter Manager", silent = true }

		vim.keymap.set("n", "<leader>T", function()
			vim.cmd.packadd(plugin.spec.name)

			require("tree-sitter-manager").setup({
				auto_install = true,
				sync_install = false,
				highlight = true,
				use_repo_queries = true,
			})

			vim.cmd("TSManager")

			-- rebind so future hits just the command
			vim.keymap.set("n", "<leader>T", "<cmd>TSManager<CR>", opts)
		end, opts)
	end,
})
