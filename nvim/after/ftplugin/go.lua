local opts = { buffer = 0 }

vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", opts)
vim.keymap.set("n", "<leader>ep", "oif err != nil {<CR>}<Esc>Opanic(err)<Esc>", opts)
vim.keymap.set("n", "<leader>ea", 'oassert.NoError(err, "")<Esc>F";a', opts)

vim.keymap.set("n", "<leader>ef", 'oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\\n", err.Error())<Esc>jj', opts)

vim.keymap.set("n", "<leader>el", 'oif err != nil {<CR>}<Esc>O.logger.Error("error", "error", err)<Esc>F.;i', opts)

vim.b.undo_ftplugin = (vim.b.undo_ftplugin or "")
	.. " | lua for _, lhs in ipairs({'<leader>ee','<leader>ep','<leader>ea','<leader>ef','<leader>el'}) do pcall(vim.keymap.del, 'n', lhs, { buffer = true }) end"
