-- luacheck: globals vim
local keymap = vim.api.nvim_set_keymap
vim.g.mapleader = " "

-- Back normal mode
keymap("i", "jj", "<ESC>", {})
keymap("i", "JJ", "<ESC>", {})

--- Save & quit
keymap('n', 'q', "<cmd>lua require('core.func').exit()<CR>", { noremap = true, silent = true })
keymap("n", "Q", ":qa!<CR>", {})
keymap('v', 'q', "<cmd>lua require('core.func').exit()<CR>", { noremap = true, silent = true })
keymap("v", "Q", ":qa!<CR>", {})
keymap("n", "w", ":w!<CR>", {})
keymap("n", "W", ":wq!<CR>", {})
keymap("v", "w", ":w!<CR>", {})
keymap("v", "W", ":wq!<CR>", {})

-- Run
keymap("n", "r", "<cmd>lua require('core.func').run()<CR>", {})
keymap("n", "R", "<cmd>lua require('core.func').run()<CR>", {})

-- Record mocro
-- 按两下小写x开始录制宏，再按一次x停止录制，按大写X执行宏
keymap("n", "x", "q", { noremap = true, silent = true })
keymap("n", "X", "@x", { noremap = true, silent = true })

-- Buffer
keymap("n", "bn", ":bn<CR>", {})
keymap("n", "bp", ":bp<CR>", {})
keymap("n", "bd", ":bd ", {})

-- Cursor move
keymap("n", "J", "<C-d>", {})
keymap("n", "K", "<C-u>", {})
keymap("v", "J", "<C-d>", {})
keymap("v", "K", "<C-u>", {})
keymap("n", "L", "E", {})
keymap("n", "H", "B", {})
keymap("n", "<C-l>", "$", {})
keymap("n", "<C-h>", "^", {})
keymap("v", "<C-l>", "$", {})
keymap("v", "<C-h>", "^", {})

--- Window management
keymap("n", "<LEADER>1", ":vnew<CR>", {})
keymap("n", "<LEADER>2", ":new<CR>", {})
keymap("n", "<A-,>", ":vertical resize -5<CR>", {})
keymap("n", "<A-.>", ":vertical resize +5<CR>", {})

--- Tab management
keymap("n", "<LEADER>tt", ":tabe<CR>", {})
keymap("n", "<LEADER>th", ":-tabnext<CR>", {})
keymap("n", "<LEADER>tl", ":+tabnext<CR>", {})

--- Neovide
if vim.g.neovide then
	keymap("n", "<C-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>", { silent = true })
	keymap("n", "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>", { silent = true })
	keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
end
