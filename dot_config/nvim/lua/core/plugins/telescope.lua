-- ~/.config/nvim/lua/plugins/telescope_config.lua
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8", -- or branch = '0.1.x',
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")

		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-n>"] = false,
						["<C-p>"] = false,
					},
				},
			},
		})

		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader><leader>", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
	end,
}
