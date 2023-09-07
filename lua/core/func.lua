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

-- 自定义函数，用于退出 Neovim
M.exit = function()
	local current_bufname = vim.fn.bufname("%")

	if current_bufname and current_bufname ~= "" and current_bufname ~= "[No Name]" then
		vim.cmd("bwipeout! " .. vim.fn.bufnr("%"))
	else
		vim.cmd("quit!")
	end
end

return M
