local theme = require("conf.theme")

hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 0,
		border_size = 3,
		col = {
			active_border = { colors = { theme.mauve, theme.blue }, angle = 45 },
			inactive_border = theme.surface0,
		},
		layout = "dwindle",
	},
	decoration = {
		rounding = 0,
		shadow = {
			enabled = false,
		},
	},
	animations = {
		enabled = false,
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
