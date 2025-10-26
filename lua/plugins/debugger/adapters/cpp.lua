-- luacheck: globals vim
local config = {
	id = "cppdbg",
	type = "executable",
	command = vim.fn.stdpath('data') .. '/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}

return config
