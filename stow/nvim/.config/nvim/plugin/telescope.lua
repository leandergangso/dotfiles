vim.pack.add({
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
}, {
	load = function(plugin)
		vim.api.nvim_create_autocmd("UIEnter", {
			once = true,
			callback = function()
				vim.cmd.packadd(plugin.spec.name)

				if plugin.spec.name ~= "telescope.nvim" then
					return
				end

				local telescope = require("telescope")
				local themes = require("telescope.themes")
				local actions = require("telescope.actions")

				local ignored = {
					".git",
					"node_modules",
					".cache",
					"dist",
					"build",
					"target",
				}
				local fd_command = {
					"fd",
					"--type",
					"file",
					"--hidden",
				}

				for _, dir in ipairs(ignored) do
					table.insert(fd_command, "--exclude")
					table.insert(fd_command, dir)
				end

				local function rg_args()
					local args = { "--hidden" }
					for _, dir in ipairs(ignored) do
						vim.list_extend(args, { "--glob", "!" .. dir .. "/*" })
					end
					return args
				end

				telescope.setup({
					defaults = {
						mappings = {
							n = {
								["dd"] = actions.delete_buffer,
							},
						},
					},
					pickers = {
						diagnostics = { initial_mode = "normal" },
						buffers = { initial_mode = "normal" },
						marks = { initial_mode = "normal" },
						find_files = {
							find_command = fd_command,
						},
						live_grep = {
							additional_args = rg_args(),
						},
					},
					extensions = {
						["ui-select"] = themes.get_dropdown({}),
					},
				})

				telescope.load_extension("ui-select")

				local builtin = require("telescope.builtin")
				--vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Search Git [P]roject" })
				vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
				vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch [G]rep" })
				vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch [W]ord" })
				vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
				vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
				vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = "[S]earch [M]arks" })
				vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
				vim.keymap.set("n", "<leader>/", function()
					builtin.current_buffer_fuzzy_find({
						previewer = false,
						layout_config = { width = 0.5, height = 0.5 },
					})
				end, { desc = "[/] Fuzzy Find" })
			end,
		})
	end,
})
