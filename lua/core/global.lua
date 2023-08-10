-- luacheck: globals vim
local global = {}

global.home = os.getenv("HOME")
global.std_config_dir = vim.fn.stdpath("config") -- .config/nvim
global.std_data_dir = vim.fn.stdpath("data") -- .local/share/nvim
global.cache_dir = global.home .. "/.cache/nvim"
global.plugins_dir = global.std_data_dir .. "/site"
global.mason_dir = global.std_data_dir .. "/mason"

return global
