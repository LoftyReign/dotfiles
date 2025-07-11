return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 100,
		confi = function()
			require("rose-pine").setup({
				variant = "main",
			})
		end,
	},
}
