-- luacheck: globals vim
local language = {}
local keymap = vim.api.nvim_set_keymap

language["iamcco/markdown-preview.nvim"] = {
	run = function()
		vim.fn["mkdp#util#install"]()
	end,
	keymap("n", "<C-c>m", "<Plug>MarkdownPreviewToggle", { noremap = true, silent = true }),
}

return language
