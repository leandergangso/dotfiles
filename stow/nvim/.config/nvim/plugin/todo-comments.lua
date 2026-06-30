vim.pack.add({
	{ src = "https://github.com/folke/todo-comments.nvim" },
}, {
	load = function(plugin)
		vim.api.nvim_create_autocmd("UIEnter", {
			once = true,
			callback = function()
				vim.cmd.packadd(plugin.spec.name)

				require("todo-comments").setup({
					signs = true,
					merge_keywords = true,
					keywords = {
						NOTE = { color = "hint" },
						TODO = { color = "info" },
						WARN = { color = "warning", alt = { "BUG" } },
						FIX = { color = "error", alt = { "DEL" } },
						TEST = { color = "test" },
						PERF = {},
					},
				})

				vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "[S]earch [T]odo" })
			end,
		})
	end,
})
