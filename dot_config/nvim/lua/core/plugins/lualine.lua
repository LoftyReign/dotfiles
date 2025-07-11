return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	priority = 1000,
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
			},
			sections = {
				lualine_a = {
					{
						"filename",
						path = 1,
					},
				},
			},
		})
	end,
}
