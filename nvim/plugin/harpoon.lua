vim.pack.add({
	{
		src = "https://github.com/ThePrimeagen/harpoon",
		version = "harpoon2",
	},
	"https://github.com/nvim-lua/plenary.nvim",
})

local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "[H]arpoon menu" })

vim.keymap.set("n", "<leader>A", function()
	harpoon:list():prepend()
end, { desc = "[A]dd to harpoon front" })

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "[a]dd to harpoon" })

vim.keymap.set("n", "<C-1>", function()
	harpoon:list():select(1)
end, { desc = "Select harpoon 1" })
vim.keymap.set("n", "<C-2>", function()
	harpoon:list():select(2)
end, { desc = "Select harpoon 2" })
vim.keymap.set("n", "<C-3>", function()
	harpoon:list():select(3)
end, { desc = "Select harpoon 3" })
vim.keymap.set("n", "<C-4>", function()
	harpoon:list():select(4)
end, { desc = "Select harpoon 4" })
vim.keymap.set("n", "<C-5>", function()
	harpoon:list():select(5)
end, { desc = "Select harpoon 5" })

vim.keymap.set("n", "<leader><C-1>", function()
	harpoon:list():replace_at(1)
end, { desc = "Replace harpoon 1" })
vim.keymap.set("n", "<leader><C-2>", function()
	harpoon:list():replace_at(2)
end, { desc = "Replace harpoon 2" })
vim.keymap.set("n", "<leader><C-3>", function()
	harpoon:list():replace_at(3)
end, { desc = "Replace harpoon 3" })
vim.keymap.set("n", "<leader><C-4>", function()
	harpoon:list():replace_at(4)
end, { desc = "Replace harpoon 4" })
vim.keymap.set("n", "<leader><C-5>", function()
	harpoon:list():replace_at(5)
end, { desc = "Replace harpoon 5" })
