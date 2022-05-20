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
keymap("n", "w", ":w<CR>", {})
keymap("n", "W", ":wq<CR>", {})
keymap("v", "w", ":w<CR>", {})
keymap("v", "W", ":wq<CR>", {})

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
keymap("n", "s", "<Nop>", {})
keymap("n", "spk", ":set nosplitbelow<CR>:split<CR>", {})
keymap("n", "spj", ":set splitbelow<CR>:split<CR>", {})
keymap("n", "sph", ":set nosplitright<CR>:vsplit<CR>", {})
keymap("n", "spl", ":set splitright<CR>:vsplit<CR>", {})
keymap("n", "smk", "<C-w>t<C-w>K", {})
keymap("n", "smj", "<C-w>t<C-w>J", {})
keymap("n", "smh", "<C-w>t<C-w>H", {})
keymap("n", "sml", "<C-w>t<C-w>L", {})
keymap("n", "<A-,>", ":vertical resize -5<CR>", {})
keymap("n", "<A-.>", ":vertical resize +5<CR>", {})
keymap("n", "sh", "<C-w>h", {})
keymap("n", "sl", "<C-w>l", {})
keymap("n", "sk", "<C-w>k", {})
keymap("n", "sj", "<C-w>j", {})

--- Tab management
keymap("n", "stt", ":tabe<CR>", {})
keymap("n", "sth", ":-tabnext<CR>", {})
keymap("n", "stl", ":+tabnext<CR>", {})
