vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-j>", "<cmd>lua vim.diagnostic.goto_next({float={source=true}})<cr>")
vim.keymap.set("n", "<C-k>", "<cmd>lua vim.diagnostic.goto_prev({float={source=true}})<cr>")
vim.keymap.set("n", "<leader>dd", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Toggle local troubleshoot" })

vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.backspace = "2"
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.autoread = true

vim.opt.scrolloff = 8

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.shiftround = true

vim.opt.wrap = false

vim.opt.cursorline = true

vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
