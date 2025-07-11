return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"lua",
				"bash",
				"vim",
				"vimdoc",
				"go",
				"javascript",
				"typescript",
				"gdscript",
				"gdshader",
			},

			sync_installed = false,
			auto_install = true,

			highlight = {
				enable = true,
			},
		})
	end,
}
