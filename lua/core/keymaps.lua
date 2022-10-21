-- luacheck: globals vim
local keymap = vim.api.nvim_set_keymap
vim.g.mapleader = " "

-- Back normal mode
keymap("i", "jj", "<ESC>", {})
keymap("i", "JJ", "<ESC>", {})

--- Save & quit
keymap("n", "q", "<cmd>lua require('core.func').quit()<CR>", {})
keymap("n", "Q", ":qa!<CR>", {})
keymap("v", "q", "<cmd>lua require('core.func').quit()<CR>", {})
keymap("v", "Q", ":qa!<CR>", {})
keymap("n", "w", ":w!<CR>", {})
keymap("n", "W", ":wq!<CR>", {})
keymap("v", "w", ":w!<CR>", {})
keymap("v", "W", ":wq!<CR>", {})

-- Run
keymap("n", "r", "<cmd>lua require('core.func').run()<CR>", {})
keymap("n", "R", "<cmd>lua require('core.func').run()<CR>", {})

-- Record mocro
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
