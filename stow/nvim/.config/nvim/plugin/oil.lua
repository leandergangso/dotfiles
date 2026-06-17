vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
})

local hidden_files = {
	["."] = true,
	[".."] = true,
	[".git"] = true,
}

require("oil").setup({
	float = {
		padding = 2,
		border = "rounded",
	},
	confirmation = {
		border = "rounded",
	},
	view_options = {
		show_hidden = false,
		is_hidden_file = function(name)
			return hidden_files[name] == true
		end,
	},
})

vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "[-] File Explorer" })
