vim.pack.add({
	"https://github.com/goolord/alpha-nvim",
})

local alpha = require("alpha")
local dashboard = require("alpha.themes.startify")

dashboard.section.header.val = {
	[[                                                                     ]],
	[[       ████ ██████           █████      ██                     ]],
	[[      ███████████             █████                             ]],
	[[      █████████ ███████████████████ ███   ███████████   ]],
	[[     █████████  ███    █████████████ █████ ██████████████   ]],
	[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
	[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
	[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
}

dashboard.section.top_buttons.val = {
	dashboard.button("h", "Check health", "<cmd>checkhealth<CR>"),
	dashboard.button("p", "Plugin health", "<cmd>checkhealth vim.pack<CR>"),
	dashboard.button("u", "Update plugins", "<cmd>lua vim.pack.update()<CR>"),
}

alpha.setup(dashboard.opts)
