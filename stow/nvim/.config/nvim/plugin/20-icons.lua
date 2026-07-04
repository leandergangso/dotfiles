vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.icons" },
})

local icons = require("mini.icons")

icons.setup({
	extension = {
		sh = { glyph = "" },
	},
	filetype = {
		dotenv = { glyph = "󰈙", hl = "MiniIconsYellow" },
	},
})

icons.mock_nvim_web_devicons()
