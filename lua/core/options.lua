-- luacheck: globals vim
local global = require("core.global")

--- Global options
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.termguicolors = true
vim.o.hidden = true
vim.o.laststatus = 2
vim.o.visualbell = true
vim.o.wildmenu = false
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
vim.o.guifont = "FiraCode Nerd Font Mono,SauceCodePro Nerd Font Mono:h18"
vim.o.backup = true
vim.o.writebackup = true
vim.o.backupdir = global.cache_dir .. "/backup"
vim.o.directory = global.cache_dir .. "/swap"
vim.o.undodir = global.cache_dir .. "/undo"

--- Neovide
if vim.g.neovide then
	vim.g.neovide_opacity = 0.8
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_cursor_vfx_mode = "pixiedust"
end

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
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = false
vim.bo.indentexpr = ""
vim.bo.autoindent = true
vim.bo.undofile = true
