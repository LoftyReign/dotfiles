local wezterm = require("wezterm")
local config = wezterm.config_builder()

---------------

config.colors = {
	cursor_bg = "#ae97c4",
	cursor_fg = "black",
	cursor_border = "white",
}

config.font = wezterm.font("FiraCode Nerd Font")

config.window_background_opacity = 0.9

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.cursor_thickness = 2
config.custom_block_glyphs = false

config.hide_tab_bar_if_only_one_tab = true

config.font_size = 13

return config
