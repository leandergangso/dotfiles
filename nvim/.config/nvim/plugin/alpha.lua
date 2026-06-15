vim.pack.add({
	"https://github.com/goolord/alpha-nvim",
})

local alpha = require("alpha")
local theme = require("alpha.themes.theta")
local dashboard = require("alpha.themes.dashboard")

theme.header.val = {
	[[                                                                     ]],
	[[       ████ ██████           █████      ██                     ]],
	[[      ███████████             █████                             ]],
	[[      █████████ ███████████████████ ███   ███████████   ]],
	[[     █████████  ███    █████████████ █████ ██████████████   ]],
	[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
	[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
	[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
}

theme.buttons.val = {
	{ type = "text", val = "Quick actions", opts = { hl = "SpecialComment", position = "center" } },
	{ type = "padding", val = 1 },
	dashboard.button("n", "  New file", "<cmd>ene<CR>"),
	dashboard.button("H", "󰒡  Check health", "<cmd>checkhealth<CR>"),
	dashboard.button("P", "󰒓  Plugin health", "<cmd>checkhealth vim.pack<CR>"),
	dashboard.button("L", "󰈚  List all plugins", "<cmd>lua require('pack').list()<CR>"),
	dashboard.button("D", "  Prune plugins", "<cmd>lua require('pack').prune()<CR>"),
	dashboard.button("U", "󰚰  Upgrade plugins", "<cmd>lua vim.pack.update()<CR>"),
	dashboard.button("q", "󰅙  Quit", "<cmd>qa<CR>"),
}

table.insert(theme.config.layout, {
	type = "padding",
	val = 2,
})

table.insert(theme.config.layout, {
	type = "text",
	val = function()
		return "nvim "
			.. vim.version().major
			.. "."
			.. vim.version().minor
			.. "."
			.. vim.version().patch
			.. "  |  "
			.. (vim.g.pack_startup_summary or "pkgs not loaded yet")
	end,
	opts = { position = "center", hl = "SpecialComment" },
})

alpha.setup(theme.config)
