-- Update monitor names after running `hyprctl monitors`.

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

-- Example multi-monitor layout mirroring the old i3 config.
-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "0x0", scale = 1, transform = 1 })
-- hl.monitor({ output = "DP-1", mode = "1920x1080@60", position = "3000x370", scale = 1 })
-- hl.monitor({ output = "DP-2", mode = "1920x1080@60", position = "1080x370", scale = 1 })
