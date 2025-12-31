-- luacheck: globals vim

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "js", "html", "css" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = false -- 使用 Tab
	end
})
