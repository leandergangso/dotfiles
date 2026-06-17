local theme = require("conf.theme")

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 4,
		border_size = 2,
		col = {
			active_border = { colors = { theme.mauve, theme.blue }, angle = 45 },
			inactive_border = theme.surface0,
		},
		layout = "dwindle",
	},
	decoration = {
		rounding = 3,
		shadow = {
			enabled = false,
		},
	},
	animations = {
		enabled = true,
		bezier = {
			"snappy, 0.2, 0.8, 0.2, 1.0",
		},
		animation = {
			"windows, 1, 2, snappy, slide",
			"windowsOut, 1, 2, snappy, slide",
			"border, 1, 2, snappy",
			"fade, 1, 2, snappy",
			"workspaces, 1, 2, snappy, slide",
		},
	},
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
	input = {
		kb_layout = "us,no",
		kb_options = "grp:win_space_toggle",
		follow_mouse = 1,
		touchpad = {
			natural_scroll = false,
		},
	},
})
