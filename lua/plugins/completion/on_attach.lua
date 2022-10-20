-- luacheck: globals vim
local keymap = vim.api.nvim_buf_set_keymap
local M = {}

M.on_attach = function(_, bufnr)
	local opts = { noremap = true, silent = true }
	keymap(bufnr, "n", "<LEADER>f", "<cmd>lua vim.lsp.buf.format { async = true } <CR>", opts)
	keymap(bufnr, "n", "rn", ":Lspsaga rename<CR>", opts)
	keymap(bufnr, "n", "rf", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "v", "<A-a>", ":<C-U>Lspsaga range_code_action<CR>", opts)
	keymap(bufnr, "n", "<A-a>", ":Lspsaga code_action<CR>", opts)
	keymap(bufnr, "n", "<A-i>", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
	keymap(bufnr, "n", "<A-n>", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
end

return M
