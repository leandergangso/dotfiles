vim.pack.add({
	"https://github.com/nvim-mini/mini.icons",
})

local icons = require("mini.icons")
local folder = { glyph = "󰉋", hl = "MiniIconsAzure" }

icons.setup({
	directory = vim.iter(icons.list("directory")):fold({}, function(acc, name)
		acc[name] = folder
		return acc
	end),
})
