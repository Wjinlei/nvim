-- luacheck: globals vim

-- Set tabstop=4
vim.cmd([[augroup SetTabstop]])
vim.cmd([[autocmd! * <buffer>]])
vim.cmd([[autocmd BufEnter <buffer> :set tabstop=8]])
vim.cmd([[autocmd BufEnter <buffer> :set shiftwidth=8]])
vim.cmd([[autocmd BufEnter <buffer> :set softtabstop=8]])
vim.cmd([[autocmd BufEnter <buffer> :set expandtab]])
vim.cmd([[augroup END]])
