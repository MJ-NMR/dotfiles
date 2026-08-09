-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output   = "",
	mode     = "preferred",
	position = "auto",
	scale    = "auto",
})


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "foot"
local fileManager = "foot yazi"
local menu        = "rofi -show drun"
local scripts     = "~/projects/scripts/"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
	hl.exec_cmd(scripts .. "hypr-poral.sh")
	hl.exec_cmd("swaybg -m fill -i ~/media/pictures/backgrounds/clown.jpeg")
	-- hl.exec_cmd("waybar -c ~/.config/waybar/hypr.jsonc")
	hl.exec_cmd("ironbar")
	hl.exec_cmd("nm-applet &dunst & fcitx5 -dr & wl-paste --type text --watch cliphist store")
	-- hl.exec_cmd("swayidle -w timeout 300 'swaylock -f -c 000000' before-sleep 'swaylock -f -c 000000'")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DISPLAY")
	-- hl.exec_cmd(
	-- 	"swayidle -w timeout 100 'brightnessctl set 10%' resume 'brightnessctl set 100%' timeout 150 'loginctl lock-session' timeout 330 'hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })'' resume 'hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'' timeout 600 'systemctl suspend' before-sleep 'loginctl lock-session' lock 'swaylock -f -c 000000'")
	hl.exec_cmd([[
		swayidle -w \
			timeout 100 'brightnessctl set 10%' \
			resume 'brightnessctl set 100%' \
			timeout 150 'loginctl lock-session' \
			timeout 330 'hyprctl dispatch dpms off' \
			resume 'hyprctl dispatch dpms on' \
			timeout 600 'systemctl suspend' \
			before-sleep 'loginctl lock-session' \
			lock 'swaylock -f -c 000000'
]])
	-- hl.exec_cmd("xfce4-power-manager")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- hl.env("XCURSOR_SIZE", "24")
-- hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "LyraQ-cursors")
hl.env("TERMINAL", terminal)
hl.env("GDK_SCALE", "1")
hl.env("GDK_DPI_SCALE", "1")
hl.env("EDITOR", "nvim")
hl.env("VISUAL", "nvim")
hl.env("XDG_CACHE_HOME", "/home/zaater/.local/cache")
hl.env("XDG_DATA_HOME", "/home/zaater/.local/share")
hl.env("XDG_CONFIG_HOME", "/home/zaater/.config")
hl.env("XDG_STATE_HOME", "/home/zaater/.local/state")
hl.env("GOPATH", "/home/zaater/.local/go")
hl.env("PATH", os.getenv("PATH") .. ":" .. os.getenv("GOPATH") .. "/bin")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in          = 0,
		gaps_out         = 0,

		border_size      = 2,

		col              = {
			active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing    = false,

		layout           = "master",

	},

	decoration = {
		rounding         = 0,
		rounding_power   = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity   = 1.0,
		inactive_opacity = 1.0,

		shadow           = {
			enabled      = false,
			range        = 4,
			render_power = 3,
			color        = 0xee1a1a1a,
		},

		blur             = {
			enabled  = false,
			size     = 3,
			passes   = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy", style = "slide" })
-- hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
-- hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "quick" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "quick" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = false, speed = 3.81, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
-- hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
-- hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "slidevert" })
-- hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "slide" })
-- hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "slide" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
hl.workspace_rule({ workspace = "special:magic", gaps_out = 30, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
hl.window_rule({
	match = { class = "app.drey.Dialect" },
	float = true,
	size = { 100, 100 }
})

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
	master = {
		new_status = "slave",
	},
	scrolling = {
		fullscreen_on_one_column = false,
		column_width = 1.0,
		focus_fit_method = 0
	},
})


----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
	},
})


---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout    = "us",
		kb_variant   = "",
		kb_model     = "",
		kb_options   = "caps:super",
		kb_rules     = "",

		follow_mouse = 0,

		sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad     = {
			natural_scroll = false,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
	name        = "epic-mouse-v1",
	sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local Mod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(Mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(Mod .. " + Delete", hl.dsp.window.close())
hl.bind(Mod .. " + SHIFT + E",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind("XF86PowerOff", hl.dsp.exec_cmd(scripts .. "power-menu.sh"))
hl.bind(Mod .. " + Y", hl.dsp.exec_cmd(fileManager))
hl.bind(Mod .. " + R", hl.dsp.window.resize())
hl.bind(Mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(Mod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(Mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(Mod .. " + TAB", function()
	local layouts = { "scrolling", "master" }
	local ws      = hl.get_active_workspace()
	if hl.get_active_special_workspace() then
		ws = hl.get_active_special_workspace()
	end

	if not ws then
		return
	end

	local next_layout = "scrolling"


	if ws.tiled_layout == layouts[1] then
		next_layout = layouts[2]
	else
		next_layout = layouts[1]
	end

	if ws.special then
		hl.workspace_rule({ workspace = tostring(ws.name), layout = next_layout })
	else
		hl.workspace_rule({ workspace = tostring(ws.id), layout = next_layout, gaps_out = { top = 0, bottom = 0, right = 0, left = 0 }, })
	end
end)

-- Switch to a submap called `resize`.
hl.bind(Mod .. " + R", function()
	hl.exec_cmd("notify-send RESIZE")
	hl.dispatch(hl.dsp.submap("resize"))
end)

-- Start a submap called "resize".
hl.define_submap("resize", function()
	-- Set repeating binds for resizing the active window.
	hl.bind("H", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("L", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })

	-- Use `reset` to go back to the global submap
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("q", hl.dsp.submap("reset"))
	hl.bind(Mod .. " + R", hl.dsp.submap("reset"))
end)

-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
-- hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with mainMod + vim keys
hl.bind(Mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(Mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(Mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(Mod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(Mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(Mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(Mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(Mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(Mod .. " + period", hl.dsp.window.center({ action = "toggle" }))
hl.bind(Mod .. " + D", hl.dsp.window.cycle_next())
hl.bind(Mod .. " + G", hl.dsp.window.pin({ action = "toggle" }))

-- apps
hl.bind(Mod .. " + P", hl.dsp.exec_cmd(scripts .. "cliphist.sh sel"))
hl.bind(Mod .. " + C", hl.dsp.exec_cmd(scripts .. "cliphist.sh copy"))
hl.bind(" Print ", hl.dsp.exec_cmd("flameshot gui"))
hl.bind(Mod .. " + T", hl.dsp.exec_cmd("dialect -n"))
hl.bind(Mod .. " + S", hl.dsp.exec_cmd('spd-say "$(wl-paste --primary)"'))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(Mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(Mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(Mod .. " + M", hl.dsp.workspace.toggle_special("magic"))
hl.bind(Mod .. " + SHIFT + M", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(Mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(Mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(Mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(Mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name           = "suppress-maximize-events",
	match          = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name     = "fix-xwayland-drags",
	match    = {
		class      = "^$",
		title      = "^$",
		xwayland   = true,
		float      = true,
		fullscreen = false,
		pin        = false,
	},

	no_focus = true,
})

hl.window_rule({
	match = { class = "zenity" },
	float = true,
})
-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name  = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move  = "20 monitor_h-120",
	float = true,
})
