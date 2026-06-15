vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
	"https://github.com/romus204/tree-sitter-manager.nvim",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})

require("tree-sitter-manager").setup({
	auto_install = true,
	sync_install = false,
	highlight = true,
	use_repo_queries = true,
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

vim.keymap.set("n", "<leader>T", "<cmd>TSManager<CR>", { desc = "[T]reesitter Manager" })
