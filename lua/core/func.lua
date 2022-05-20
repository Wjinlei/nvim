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

return M
