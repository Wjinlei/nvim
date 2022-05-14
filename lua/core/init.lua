-- luacheck: globals vim

local main = function()
	require("core.options")
	require("core.keymaps")
	require("core.autocmd")

	vim.api.nvim_command(
		[[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
	)
end

main()
