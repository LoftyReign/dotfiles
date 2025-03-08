local wezterm = require("wezterm")

local home = os.getenv("USERPROFILE") or os.getenv("HOME")

local theme_file = home .. "/AppData/Local/state-cache/wezterm_theme.txt"
local default_theme = "Catppuccin Frappe"

local ColorScheme = {}

------ Theme switcher

function ColorScheme:get_last_theme()
	local file = io.open(theme_file, "r")
	if file then
		local theme = file:read("l")
		file:close()
		return theme
	end
	return default_theme
end

local function update_theme_state(theme)
	local file = io.open(theme_file, "w")
	if file then
		file:write(theme)
		file:close()
	end
end
local function apply_theme(window, theme)
	local overrides = window:get_config_overrides() or {}
	overrides.color_scheme = theme
	window:set_config_overrides(overrides)

	update_theme_state(theme)
end

function ColorScheme:change_theme(window, pane)
	local schemes = wezterm.get_builtin_color_schemes()
	local choices = {}

	for key, _ in pairs(schemes) do
		table.insert(choices, { label = tostring(key) })
	end

	table.sort(choices, function(c1, c2)
		return c1.label < c2.label
	end)

	window:perform_action(
		wezterm.action.InputSelector({
			title = "Pick a Theme!",
			choices = choices,
			fuzzy = true,

			action = wezterm.action_callback(function(_, _, _, label)
				if label then
					apply_theme(window, label)
				else
					apply_theme(window, ColorScheme:get_last_theme())
				end
			end),
		}),
		pane
	)
end

------ Theme switcher

return ColorScheme
