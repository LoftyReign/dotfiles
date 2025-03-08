local wezterm = require("wezterm")
local utils = require("utils")

local home = os.getenv("USERPROFILE") or os.getenv("HOME")

local dimmer = { brightness = 0.075 }
local backdrop_path = home .. "/.wezterm/backdrops"

local backdrop_file = home .. "/.wezterm/cache/wezterm_backdrop.txt"
local default_backdrop = backdrop_path .. "/4.jpg"

local BackDrops = {}

------ Backdrop switcher

local function get_last_backdrop()
	local file = io.open(backdrop_file, "r")
	if file then
		local backdrop = file:read("l")
		file:close()
		return backdrop
	end
	return default_backdrop
end

local function update_backdrop_state(backdrop)
	local file = io.open(backdrop_file, "w")
	if file then
		file:write(backdrop)
		file:close()
	end
end

local function apply_backdrop(window, backdrop)
	local overrides = window:get_config_overrides() or {}
	overrides.background = {
		{
			source = {
				File = backdrop_path .. "/" .. backdrop,
			},
			hsb = dimmer,
		},
	}
	window:set_config_overrides(overrides)

	update_backdrop_state(backdrop)
end

function BackDrops:change_backdrop(window, pane)
	local choices = {}

	for _, file in ipairs(wezterm.glob(backdrop_path .. "/*")) do
		print("File from for: " .. file)
		local split_file_path = utils:split_string(file, "/")
		table.insert(choices, { label = split_file_path[#split_file_path] })
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
					apply_backdrop(window, label)
				else
					apply_backdrop(window, get_last_backdrop())
				end
			end),
		}),
		pane
	)
end

------ Backdrop switcher

------ Background toggle

function BackDrops:toggle_background(window, _)
	local overrides = window:get_config_overrides() or {}
	if not overrides.background then
		overrides.background = {
			{
				source = {
					File = backdrop_path .. "/" .. get_last_backdrop(),
				},
				hsb = dimmer,
			},
		}
	else
		overrides.background = nil
	end
	window:set_config_overrides(overrides)
end

------ Background toggle

return BackDrops
