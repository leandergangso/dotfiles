vim.pack.add({
	{
		src = "https://github.com/ThePrimeagen/harpoon",
		version = "harpoon2",
	},
}, {
	load = function(plugin)
		vim.api.nvim_create_autocmd("UIEnter", {
			once = true,
			callback = function()
				vim.cmd.packadd(plugin.spec.name)

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

				-- Jump and Replace loops (1 to 5)
				for i = 1, 5 do
					vim.keymap.set("n", string.format("<C-%d>", i), function()
						harpoon:list():select(i)
					end, { desc = string.format("Select harpoon %d", i) })

					vim.keymap.set("n", string.format("<leader><C-%d>", i), function()
						harpoon:list():replace_at(i)
					end, { desc = string.format("Replace harpoon %d", i) })
				end
			end,
		})
	end,
})
