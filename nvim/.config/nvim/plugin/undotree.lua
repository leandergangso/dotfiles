vim.pack.add({
	"https://github.com/mbbill/undotree",
})

vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "[U]ndo Tree" })
