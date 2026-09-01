local mod = "SUPER"
local terminal = "kitty"
local file_manager = "thunar"
local launcher = "hyprlauncher"
local lock = "hyprlock"

--hl.bind(mod .. " + Space", hl.dsp.exec_cmd("hyprctl switchxkblayout all next"))

hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + e", hl.dsp.exec_cmd(file_manager))
hl.bind(mod .. " + c", hl.dsp.window.close())
hl.bind(mod .. " + d", hl.dsp.exec_cmd(launcher))
hl.bind(mod .. " + CTRL + SHIFT + h", hl.dsp.exec_cmd("systemctl suspend"))
hl.bind(mod .. " + CTRL + l", hl.dsp.exec_cmd(lock))
hl.bind(
	mod .. " + m",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(
	mod .. "+ SHIFT + s",
	hl.dsp.exec_cmd(
		'grim -g "$(slurp)" - | satty -f - --copy-command wl-copy -o "~/Pictures/Screenshots/%Y%m%d_%H%M%S.png"'
	)
)

hl.bind(mod .. " + v", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + p", hl.dsp.window.pseudo())
--hl.bind(momod .. " + j", hl.dsp.layout("togglesplit")) -- dwindle only

hl.bind(mod .. " + j", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + k", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + l", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + semicolon", hl.dsp.focus({ direction = "right" }))

hl.bind(mod .. " + SHIFT + j", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + k", hl.dsp.window.move({ direction = "down" }))
hl.bind(mod .. " + SHIFT + l", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + semicolon", hl.dsp.window.move({ direction = "right" }))

hl.bind(mod .. " + q", hl.dsp.layout("togglesplit"))
hl.bind(mod .. " + f", hl.dsp.window.fullscreen())
hl.bind(mod .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mod .. " + PERIOD", hl.dsp.focus({ monitor = "-1" }))
hl.bind(mod .. " + COMMA", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mod .. " + SHIFT + PERIOD", hl.dsp.window.move({ monitor = "-1" }))
hl.bind(mod .. " + SHIFT + COMMA", hl.dsp.window.move({ monitor = "+1" }))

for i = 1, 10 do
	local key = i % 10
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
--hl.bind(mainMod .. " + s", hl.dsp.workspace.toggle_special("magic"))
--hl.bind(mainMod .. " + SHIFT + s", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mod .. " + n", hl.dsp.exec_cmd("playerctl next"))
hl.bind(mod .. " + b", hl.dsp.exec_cmd("playerctl previous"))

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_raw("wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+"),
	{ repeating = true, locked = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_raw("wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-"),
	{ repeating = true, locked = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_raw("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_raw("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
