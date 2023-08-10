-- luacheck: globals vim

-- Set tabstop=4
vim.cmd([[augroup SetTabstop]])
vim.cmd([[autocmd! * <buffer>]])
vim.cmd([[autocmd BufEnter * :set tabstop=4]])
vim.cmd([[autocmd BufEnter * :set shiftwidth=4]])
vim.cmd([[autocmd BufEnter * :set softtabstop=4]])
vim.cmd([[autocmd BufEnter * :set expandtab]])
vim.cmd([[augroup END]])
