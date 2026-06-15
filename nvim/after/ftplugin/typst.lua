if vim.g.typst_preview_plugin then
	return
end
vim.g.typst_preview_plugin = true

vim.pack.add({
	"https://github.com/chomosuke/typst-preview.nvim",
})

require("typst-preview").setup({
	follow_cursor = true,
	dependencies_bin = {
		tinymist = vim.fn.exepath("tinymist"),
		websocat = vim.fn.exepath("websocat"),
	},
})
