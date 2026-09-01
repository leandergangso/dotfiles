-- see `hyprctl monitors`

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@60",
	position = "0x0",
	transform = 1,
	scale = 1,
})

hl.monitor({
	output = "DP-2",
	mode = "1920x1080@60",
	position = "1080x370",
	scale = 1,
})

hl.monitor({
	output = "DP-1",
	mode = "1920x1080@60",
	position = "3000x370",
	scale = 1,
})

--hl.monitor({
--	output = "",
--	mode = "preferred",
--	position = "auto",
--	scale = 1,
--})
