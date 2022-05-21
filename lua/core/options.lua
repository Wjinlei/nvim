-- luacheck: globals vim
local global = require("core.global")

--- Global options
vim.o.termguicolors = true
vim.o.hidden = true
vim.o.laststatus = 2
vim.o.visualbell = true
vim.o.wildmenu = true
vim.o.showmode = true
vim.o.showcmd = true
vim.o.inccommand = "split"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.lazyredraw = true
vim.o.updatetime = 100
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.o.guifont = "JetBrainsMono Nerd Font Mono:h15"
vim.o.backup = true
vim.o.writebackup = true
vim.o.backupdir = global.cache_dir .. "backup"
vim.o.directory = global.cache_dir .. "swap"
vim.o.undodir = global.cache_dir .. "undo"

--- Local window options
vim.wo.wrap = true
vim.wo.list = true
vim.wo.listchars = "tab:> ,trail:.,nbsp:+"
-- vim.wo.relativenumber = true
vim.wo.number = true
vim.wo.scrolloff = 30
vim.wo.foldenable = true
vim.wo.foldmethod = "indent"
vim.wo.foldlevel = 99
vim.wo.signcolumn = "yes"

--- Local buffer options
vim.bo.fileencoding = "utf-8"
vim.bo.tabstop = 8
vim.bo.shiftwidth = 8
vim.bo.softtabstop = 8
vim.bo.expandtab = true
vim.bo.indentexpr = ""
vim.bo.autoindent = true
vim.bo.undofile = true
