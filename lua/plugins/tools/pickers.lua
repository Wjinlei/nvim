-- luacheck: globals vim
local M = {}

M.project_files = function()
	local opts = {
		previewer = false,
	} -- define here if you want to define something
	local ok = pcall(require("telescope.builtin").git_files, opts)
	if not ok then
		require("telescope.builtin").find_files(opts)
	end
end

M.project_change_files = function()
	local ok = pcall(require("telescope.builtin").git_status)
	if not ok then
		require("telescope.builtin").find_files()
	end
end

M.shell_error = function()
	return vim.v.shell_error ~= 0
end

M.git_root = function(cwd)
	local cmd = M.git_cwd("git rev-parse --show-toplevel", cwd)
	local output = vim.fn.systemlist(cmd)
	if M.shell_error() then
		return nil
	end
	return output[1]
end

M.git_cwd = function(cmd, cwd)
	if not cwd then
		return cmd
	end
	cwd = vim.fn.expand(cwd)
	local arg_cwd = ("-C %s "):format(vim.fn.shellescape(cwd))
	cmd = cmd:gsub("^git ", "git " .. arg_cwd)
	return cmd
end

M.search = function()
	require("telescope").extensions.live_grep_raw.live_grep_raw({ cwd = M.git_root() })
end
return M
