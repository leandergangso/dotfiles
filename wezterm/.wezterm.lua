local wezterm = require("wezterm")
local cfg = wezterm.config_builder()

cfg.font = wezterm.font("JetBrainsMono Nerd Font")
cfg.font_size = 11
cfg.line_height = 1.2

cfg.color_scheme = "Catppuccin Mocha"

cfg.enable_tab_bar = false
cfg.tab_bar_at_bottom = true
cfg.window_decorations = "RESIZE"

cfg.keys = {
    {
        key = "p",
        mods = "CTRL|SHIFT",
        action = wezterm.action.DisableDefaultAssignment,
    },
    {
        key = "Backspace",
        mods = "CTRL",
        action = wezterm.action.SendString("\x17"),
    },
}

return cfg
