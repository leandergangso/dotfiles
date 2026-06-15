vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
})

local telescope = require("telescope")

telescope.setup({
	pickers = {
		diagnostics = { initial_mode = "normal" },
		buffers = { initial_mode = "normal" },
		marks = { initial_mode = "normal" },
	},
	extensions = {
		["ui-select"] = require("telescope.themes").get_dropdown({}),
	},
})

telescope.load_extension("ui-select")

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
	builtin.current_buffer_fuzzy_find({
		previewer = false,
		layout_config = { width = 0.5, height = 0.4 },
	})
end, { desc = "[/] Fuzzy Find" })
