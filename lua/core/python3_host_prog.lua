local M = {}

-- 检查并设置Python3主机程序路径
M.setup_python_host = function()
    if vim.g.python3_host_prog then
        return
    end

    local config_file = vim.fn.stdpath('config') .. '/python_host.lua'
    local config_dir = vim.fn.fnamemodify(config_file, ':h')

    if vim.fn.filereadable(config_file) == 0 then
        local file = io.open(config_file, 'w')
        if file then
            file:write('-- Python3路径配置\n')
            file:write('-- 请设置你的Python3可执行文件路径\n')
            file:write('-- 例如: vim.g.python3_host_prog = "/usr/bin/python3"\n')
            file:write('-- 或者: vim.g.python3_host_prog = "C:\\\\Python39\\\\python.exe"\n\n')
            file:write('vim.g.python3_host_prog = ""\n')
            file:close()
        end

        vim.notify('Please set the Python 3 executable file path', vim.log.levels.INFO)

        -- 使用schedule确保在Neovim完全启动后打开文件
        vim.schedule(function()
            vim.cmd('edit ' .. config_file)
            vim.cmd('normal! G$')
        end)
    else
        vim.notify('Load python3 executable file path', vim.log.levels.INFO)
        dofile(config_file)

        -- 检查配置是否已设置
        if not vim.g.python3_host_prog or vim.g.python3_host_prog == '' then
            vim.notify('Please set the Python 3 executable file path: ' .. config_file, vim.log.levels.WARN)
        else
            vim.notify('python3_host_prog=' .. vim.g.python3_host_prog, vim.log.levels.INFO)
        end
    end
end

-- 自动执行设置
vim.schedule(function()
    M.setup_python_host()
end)

return M
