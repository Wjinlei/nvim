-- luacheck: globals vim
local config = {
	type = "executable",
	command = vim.fn.stdpath('data') .. '/mason/packages/codelldb/codelldb',
}

return config
