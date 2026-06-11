return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				--defaults = {
				--    vimgrep_arguments = {
				--        "rg",
				--        "--color=never",
				--        "--no-heading",
				--        "--with-filename",
				--        "--line-number",
				--        "--column",
				--        "--smart-case",
				--        "--hidden",    -- include hidden files for all grep pickers
				--        "--no-ignore", -- include .gitignore ignored files for all grep pickers
				--        "--glob",
				--        "!**/.git/*",  -- exclude .git directory
				--    },
				--},
				pickers = {
					--find_files = {
					--    hidden = true,    -- show hidden files in find_files picker
					--    no_ignore = true, -- include gitignored files in find_files picker
					--    find_command = {
					--        "rg",
					--        "--files",
					--        "--hidden",
					--        "--no-ignore",
					--        "--glob",
					--        "!**/.git/*",
					--    },
					--},
					diagnostics = { initial_mode = "normal" },
					buffers = { initial_mode = "normal" },
					marks = { initial_mode = "normal" },
				},
			})
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Search Git [P]roject" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch [G]rep" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch [W]ord" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
			vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = "[S]earch [M]arks" })
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find({ previewer = false, layout_config = { width = 0.5, height = 0.4 } })
			end, { desc = "[/] Fuzzy Find" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
