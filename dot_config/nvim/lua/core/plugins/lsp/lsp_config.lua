return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				PATH = "prepend",
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
	},
	{
		"whoissethdaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"gopls",
					"lua_ls",
					"bash-language-server",
					"stylua",
					"gofumpt",
					"goimports",
				},
				auto_update = true, -- Automatically update tools
				run_on_start = true, -- Run installation on start
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			-- Define an `on_attach` function to configure keymaps for LSP actions
			local on_attach = function(_, _)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
				vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
				vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			end
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			local lspconfig = require("lspconfig")
			local util = require("lspconfig/util")

			-- Configure each LSP server with `on_attach`
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				cmd = { "lua-language-server", "--force-accept-workspace" },
				settings = {
					Lua = {
						completion = {
							callSnippet = "Both",
						},
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			lspconfig.gopls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = util.root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
						},
					},
				},
			})
			lspconfig.gdscript.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "gd", "gdscript", "gdscript3" },
			})
			lspconfig.bashls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,
	},
}
