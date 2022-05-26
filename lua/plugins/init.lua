-- luacheck: globals vim
local keymap = vim.api.nvim_set_keymap
local main = function()
	local pack = require("plugins.packer")
	pack:init()
end
keymap("n", "<C-x>u", ":PackerSync<CR>", { noremap = true, silent = true })
keymap("n", "<C-x>i", ":PackerInstall<CR>", { noremap = true, silent = true })
main()
