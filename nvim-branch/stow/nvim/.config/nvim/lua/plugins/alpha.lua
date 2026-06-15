return {
	"goolord/alpha-nvim",
	dependencies = { { "nvim-tree/nvim-web-devicons", opts = {} } },
	config = function()
		local alpha = require("alpha")
		--local dashboard = require("alpha.themes.dashboard")
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
			[[                                                                       ]],
			[[                                                                       ]],
		}

		--dashboard.section.footer.val = "Total plugins: " .. require("lazy").stats().count

		--dashboard.section.buttons.val = {
		--    dashboard.button("s", " Open last session", ":PossessionLoadCurrent<CR>"),
		--    dashboard.button("h", " Recently opened files", ":Telescope my_mru<CR>"),
		--    dashboard.button("f", " Find file", ":Telescope find_files<CR>"),
		--    dashboard.button("e", " New file", ":enew<CR>"),
		--    dashboard.button("b", " Jump to bookmarks", ":Telescope marks<CR>"),
		--    dashboard.button("n", " Memo New", ":Telekasten new_note<CR>"),
		--    dashboard.button("t", " Memo Today", ":Telekasten goto_today<CR>"),
		--    dashboard.button("w", " Memo Week", ":Telekasten goto_thisweek<CR>"),
		--    dashboard.button("m", " Memo List", ":Telekasten find_notes<CR>"),
		--    dashboard.button("p", " Update plugins", ":Lazy sync<CR>"),
		--    dashboard.button("q", " Exit", ":qa<CR>"),
		--}

		alpha.setup(dashboard.opts)
	end,
}
