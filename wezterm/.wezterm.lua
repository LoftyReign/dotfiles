local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()

local backdrops = require("backdrops")
local color_schemes = require("color_schemes")

local defautl_shell_path = "C:/Program Files/Git/bin/bash.exe"
local default_shell_args = { defautl_shell_path, "-i", "-l" }

---------------

-- Start Wezterm in fullscreen
wezterm.on("gui-startup", function()
	local _, _, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

config.colors = {
	cursor_bg = "#ae97c4",
	cursor_fg = "black",
}

-- Configure hotkeys for background togglling and theme switching
config.keys = {
	{
		key = "|",
		mods = "ALT|SHIFT",
		action = wezterm.action_callback(function(window, pane)
			backdrops:change_backdrop(window, pane)
		end),
	},
	{
		key = "\\",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			backdrops:toggle_background(window, pane)
		end),
	},
	{
		key = "}",
		mods = "ALT|SHIFT",
		action = wezterm.action_callback(function(window, pane)
			color_schemes:change_theme(window, pane)
		end),
	},

	-- Splitting panes
	{
		key = "Y",
		mods = "ALT",
		action = wezterm.action.SplitPane({
			direction = "Left",
			size = { Percent = 50 },
		}),
	},
	{
		key = "U",
		mods = "ALT",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		key = "I",
		mods = "ALT",
		action = wezterm.action.SplitPane({
			direction = "Up",
			size = { Percent = 50 },
		}),
	},
	{
		key = "O",
		mods = "ALT",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},

	-- Navigating panes and tabs
	{
		key = "H",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			local tab = window:mux_window():active_tab()
			if tab:get_pane_direction("Left") ~= nil then
				window:perform_action(wezterm.action.ActivatePaneDirection("Left"), pane)
			else
				window:perform_action(wezterm.action.ActivateTabRelative(-1), pane)
			end
		end),
	},
	{
		key = "J",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "K",
		mods = "ALT",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "L",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			local tab = window:mux_window():active_tab()
			if tab:get_pane_direction("Right") ~= nil then
				window:perform_action(wezterm.action.ActivatePaneDirection("Right"), pane)
			else
				window:perform_action(wezterm.action.ActivateTabRelative(1), pane)
			end
		end),
	},
}

config.color_scheme = color_schemes:get_last_theme()
config.font = wezterm.font("FiraCode Nerd Font")
config.default_cursor_style = "SteadyBlock"
config.hide_tab_bar_if_only_one_tab = true

config.font_size = 14.5

-- Use bash as terminal
config.default_prog = default_shell_args

-- Explicitly allow scrolling and turn off history scrolling
config.disable_default_mouse_bindings = true

config.mouse_bindings = {
	{
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		mods = "NONE",
		action = wezterm.action.ScrollByLine(-1),
	},
	{
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		mods = "NONE",
		action = wezterm.action.ScrollByLine(1),
	},
}

return config
