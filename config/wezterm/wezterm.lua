local wezterm = require("wezterm")
local config = {
	font_size = 13,
	font = wezterm.font_with_fallback({
		{ family = "FiraCode Nerd Font" },
		{ family = "Maple Mono NF" },
		{ family = "Liga SFMono Nerd Font", weight = "Medium" },
		{ family = "Apple Color Emoji" },
		{ family = "MiSans VF", weight = "Medium" },
	}),
	font_rules = {
		{
			italic = true,
			font = wezterm.font({
				-- Italic Test
				family = "VictorMono Nerd Font",
				weight = "Medium",
				style = "Italic",
			}),
		},
	},
	window_padding = {
		left = 30,
		right = 30,
		top = 30,
		bottom = 30,
	},
	line_height = 1.4,
	cell_width = 0.9,
	adjust_window_size_when_changing_font_size = false,
	enable_wayland = true,
	freetype_load_flags = "NO_HINTING|NO_AUTOHINT",
	color_scheme = "Catppuccin Mocha",
	use_fancy_tab_bar = false,
	window_decorations = "NONE",
	show_new_tab_button_in_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	enable_tab_bar = true,
	colors = {
		tab_bar = {
			background = "rgba(12%, 12%, 18%, 90%)",
			active_tab = {
				bg_color = "#cba6f7",
				fg_color = "rgba(12%, 12%, 18%, 0%)",
				intensity = "Bold",
			},
			inactive_tab = {
				fg_color = "#cba6f7",
				bg_color = "rgba(12%, 12%, 18%, 90%)",
				intensity = "Normal",
			},
			inactive_tab_hover = {
				fg_color = "#cba6f7",
				bg_color = "rgba(27%, 28%, 35%, 90%)",
				intensity = "Bold",
			},
			new_tab = {
				fg_color = "#808080",
				bg_color = "#1e1e2e",
			},
		},
	},
}
return config
