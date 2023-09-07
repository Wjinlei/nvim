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
	-- 获取当前 buffer 的名字和编号
	local current_bufname = vim.fn.bufname("%")
	local current_bufnr = vim.fn.bufnr("%")

	-- 如果当前 buffer 不是空白或者 "[No Name]"，就调用 bwipeout! 删除它
	if current_bufname and current_bufname ~= "" and current_bufname ~= "[No Name]" then
		-- 添加一个短暂的延迟，确保 buffer 已经完全加载
		vim.defer_fn(function()
			-- 检查当前 buffer 是否仍然存在
			if vim.api.nvim_buf_is_valid(current_bufnr) then
				vim.cmd("bwipeout! " .. current_bufnr)
			end
		end, 10) -- 延迟 10 毫秒
	else
		-- 否则执行 quit
		vim.cmd("quit")
	end
end

return M
