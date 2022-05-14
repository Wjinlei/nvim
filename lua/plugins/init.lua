-- luacheck: globals vim
local keymap = vim.api.nvim_set_keymap
local main = function()
	local pack = require("plugins.packer")
	pack:init()
end
keymap("n", "<C-x>", ":PackerSync<CR>", { noremap = true, silent = true })
main()
