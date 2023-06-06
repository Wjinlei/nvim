-- luacheck: globals vim
local global = {}

global.home = os.getenv("HOME")
global.cache_dir = global.home .. "/.cache/nvim/"
global.config_path = vim.fn.stdpath("config")
global.data_dir = string.format("%s/site/", vim.fn.stdpath("data"))
global.mason_dir = string.format("%s/mason/", vim.fn.stdpath("data"))

return global
