local mod = "SUPER"
local terminal = "kitty"
local file_manager = "thunar"
local launcher = "wofi --show drun"
local lock = "hyprlock"

hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + SHIFT + N", hl.dsp.exec_cmd(file_manager))
hl.bind(mod .. " + C", hl.dsp.window.close())
hl.bind(mod .. " + CTRL + SHIFT + H", hl.dsp.exec_cmd("systemctl suspend"))
hl.bind(mod .. " + CTRL + L", hl.dsp.exec_cmd(lock))
hl.bind(mod .. " + D", hl.dsp.exec_cmd(launcher))
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd("flameshot gui"))

hl.bind(mod .. " + J", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + semicolon", hl.dsp.focus({ direction = "right" }))

hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "down" }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + semicolon", hl.dsp.window.move({ direction = "right" }))

hl.bind(mod .. " + Q", hl.dsp.layout("togglesplit"))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))

for i = 1, 10 do
	local key = i % 10
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +3%"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -3%"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { locked = true })

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
