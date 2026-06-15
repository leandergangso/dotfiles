vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
})

-- NOTE: use this once NIX handles all parser installs
--vim.api.nvim_create_autocmd("FileType", {
--	callback = function(args)
--		pcall(vim.treesitter.start, args.buf)
--	end,
--})

local parsers = {
	"lua",
	"html",
	"css",
	"vimdoc",
	"jsdoc",
	"bash",
	"go",
	-- "astro",
	-- "svelte",
	-- "python",
	-- "javascript",
	-- "typescript",
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = parsers,
	callback = function()
		vim.treesitter.start()
	end,
})

require("nvim-treesitter").install(parsers)

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
