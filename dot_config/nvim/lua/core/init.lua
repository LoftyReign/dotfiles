-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

--Set leaderkey with something to insure it works
vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.keymaps")
require("lazy").setup("core.plugins")

-- Theme setup thingy

local home = os.getenv("USERPROFILE") or os.getenv("HOME")
local theme_file = home .. "/AppData/Local/state-cache/nvim_theme.txt"
local default_theme = "rose-pine"

---------------

local function get_last_theme()
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

local function setTheme(theme)
	require("lualine").setup({
		options = { theme = theme },
	})

	vim.cmd("colorscheme " .. theme)

	-- transparent background
	vim.o.termguicolors = true

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

	update_theme_state(theme)
end

vim.api.nvim_create_user_command("Theme", function(opts)
	setTheme(opts.args)
end, {
	nargs = 1,
	complete = function()
		return vim.fn.getcompletion("", "color")
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyLoad",
	callback = function(plugin)
		local last_theme = get_last_theme()

		local safe_pattern = plugin.data:gsub("([^%w])", "%%%1")
		if last_theme:match(safe_pattern) then
			setTheme(last_theme)
		end
	end,
})
