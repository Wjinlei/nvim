-- luacheck: globals vim
local api = vim.api
local M = {}

M.quit = function()
	if api.nvim_buf_get_name(api.nvim_get_current_buf()) ~= "" then
		api.nvim_command("bdelete!")
	else
		api.nvim_command("quit!")
	end
end

M.run = function()
	api.nvim_command("w")
	if vim.bo.filetype == "c" then
		api.nvim_command("term gcc % -o %< && ./%< && rm -f %<")
	end
	if vim.bo.filetype == "go" then
		api.nvim_command("term go run %<.go")
	end
end

return M
