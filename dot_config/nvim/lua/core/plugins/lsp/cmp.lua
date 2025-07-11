return {
	-- Existing LSP setup as in your previous configuration
	-- Your existing plugins...

	-- nvim-cmp and its sources
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
			"hrsh7th/cmp-buffer", -- Buffer source for text in the current buffer
			"hrsh7th/cmp-path", -- Path source for file paths
			"hrsh7th/cmp-cmdline", -- Command-line source
			"saadparwaiz1/cmp_luasnip", -- Snippet source
			"L3MON4D3/LuaSnip", -- Snippet engine
			"rafamadriz/friendly-snippets",
		},
		config = function()
			-- Load friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Set up nvim-cmp
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For luasnip users
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Raplace }), -- Accept selected item
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			-- Set up completion for command-line mode
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "path" },
					{ name = "cmdline" },
				},
			})
		end,
	},
}
