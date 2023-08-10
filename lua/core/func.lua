-- luacheck: globals vim
local api = vim.api
local M = {}

M.run = function()
	if vim.bo.filetype == "c" then
		api.nvim_command("term gcc % -o %< && ./%< && rm -f %<")
	end
	if vim.bo.filetype == "go" then
		api.nvim_command("term go run %<.go")
	end
	if vim.bo.filetype == "rust" then
		api.nvim_command("term cargo run")
	end
end

return M
