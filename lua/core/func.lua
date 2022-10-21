-- luacheck: globals vim
local api = vim.api
local M = {}

M.quit = function()
	local output = api.nvim_command_output("echo len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))")
	if output == "1" then
		api.nvim_command("quit!")
	else
		api.nvim_buf_delete(0, { force = 1 })
	end
end

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
