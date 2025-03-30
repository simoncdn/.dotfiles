-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config = {
	automatically_reload_config = true,

	-- Set the window title
	enable_tab_bar = false,
	window_decorations = "RESIZE",

	-- Set the window
	window_background_opacity = 0.85,
	macos_window_background_blur = 30,
	window_padding = {
		left = 32,
		right = 32,
		top = 32,
		bottom = 12,
	},

	-- Set the theme
	color_scheme = "Tokyo Night",
	colors = {
		background = "#0e101a",
	},

	-- Font configuration
	font = wezterm.font("Dank Mono", {
		-- weight = "Regular",
		weight = "Bold",
		italic = false,
	}),
	line_height = 1.3,
	font_size = 16.0,
}

-- and finally, return the configuration to wezterm
return config
