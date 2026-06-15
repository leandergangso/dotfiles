return {
	"folke/which-key.nvim",
	event = "VimEnter",
	enabled = true,
	lazy = true,
	opts = {
		delay = 3000,
		icons = {
			mappings = true,
			keys = {},
		},
		--spec = {
		--{ '<leader>',  group = '?' },
		--{ '<leader>c', group = '[C]ode',     mode = { 'n', 'x' } },
		--{ '<leader>d', group = '[D]ocument' },
		--{ '<leader>r', group = '[R]ename' },
		--{ '<leader>s', group = '[S]earch' },
		--{ '<leader>w', group = '[W]orkspace' },
		--{ '<leader>t', group = '[T]oggle' },
		--{ '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
		--},
	},
}
