local wezterm = require("wezterm")
local cfg = wezterm.config_builder()

cfg.font_size = 11
cfg.font = wezterm.font("FiraCode Nerd Font")

cfg.color_scheme = "Catppuccin Mocha"

cfg.enable_tab_bar = false
cfg.tab_bar_at_bottom = true
cfg.window_decorations = "RESIZE"

--cfg.keys = {
--	{
--		key = '"',
--		mods = "CTRL|SHIFT|ALT",
--		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
--	},
--}

return cfg
