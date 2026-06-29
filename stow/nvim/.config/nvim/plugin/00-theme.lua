vim.pack.add({
	{
		src = "https://github.com/catppuccin/nvim",
		name = "catppuccin",
	},
})

require("catppuccin").setup({
	compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
})

vim.cmd.colorscheme("catppuccin-mocha")
