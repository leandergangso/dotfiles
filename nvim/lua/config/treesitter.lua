local M = {}

M.parsers = {
	"lua",
	"html",
	"css",
	"vimdoc",
	"jsdoc",
	"bash",
	"go",
	--"astro",
	--"svelte",
	--"python",
	--"javascript",
	--"typescript",
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = M.parsers,
	callback = function()
		vim.treesitter.start()
	end,
})

return M
