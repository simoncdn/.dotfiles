-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config = {
	automatically_reload_config = true,

	-- Set the window title
	enable_tab_bar = false,
	window_decorations = "RESIZE",

	window_background_opacity = 0.85,
	macos_window_background_blur = 30,
	window_padding = {
		left = 32,
		right = 32,
		top = 32,
		bottom = 32,
	},
	-- Set the default cursor style
	-- cursor_style = "BlinkingBlock",

	-- background								#0e101a
	-- background_blur						30
	-- For example, changing the color scheme:
	color_scheme = "tokyonight_night",
	colors = {
		background = "#0e101a",
	},

	-- Font configuration
	font = wezterm.font("Dank Mono", { weight = "Bold", italic = false }),
	font_size = 16.0,
}

-- and finally, return the configuration to wezterm
return config
