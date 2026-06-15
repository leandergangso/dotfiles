vim.pack.add({
	{
		src = "https://github.com/Saghen/blink.cmp",
		version = vim.version.range("1"),
	},
	--"github.com/rafamadriz/friendly-snippets",
})

require("blink.cmp").setup({
	keymap = {
		preset = "default",
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = {
			auto_show = false,
		},
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	snippets = {
		preset = "default",
	},
	fuzzy = {
		implementation = "prefer_rust_with_warning",
	},
})
