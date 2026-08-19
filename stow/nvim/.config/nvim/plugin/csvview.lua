vim.pack.add({
	{ src = "https://github.com/hat0uma/csvview.nvim" },
}, {
	load = function(plugin)
		vim.api.nvim_create_autocmd("FileType", {
			once = true,
			pattern = "csv",
			callback = function()
				vim.cmd.packadd(plugin.spec.name)
				require("csvview").setup({
					parser = { comments = { "#", "//" } },
					view = {
						display_mode = "highlight", -- or "border"
					},
					keymaps = {
						textobject_field_inner = { "if", mode = { "o", "x" } },
						textobject_field_outer = { "af", mode = { "o", "x" } },
						jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
						jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
						jump_next_row = { "<Enter>", mode = { "n", "v" } },
						jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
					},
				})

				require("csvview").enable()

				vim.api.nvim_create_autocmd("FileType", {
					pattern = "csv",
					callback = function()
						require("csvview").enable()
						vim.notify("CsvView was enabled")
					end,
				})
			end,
		})
	end,
})
