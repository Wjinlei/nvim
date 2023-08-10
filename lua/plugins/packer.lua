-- luacheck: globals vim
local fn, api = vim.fn, vim.api
local nvim_plugins_dir = require("core.global").plugins_dir
local config_dir = require("core.global").std_config_dir
local packer_compiled = nvim_plugins_dir .. "/lua/_compiled.lua"
local plugins_directory = config_dir .. "/lua/plugins"

local packer = nil
local Packer = {}

function Packer:load_plugins()
	self.repos = {}
	local get_plugins_list = function()
		local list = {}
		local tmp = vim.split(fn.globpath(plugins_directory, "*/plugins.lua"), "\n")
		for _, f in ipairs(tmp) do
			list[#list + 1] = f:sub(#plugins_directory - 6, -1)
		end
		return list
	end

	for _, m in ipairs(get_plugins_list()) do
		local repos = require(m:sub(0, #m - 4))
		for repo, conf in pairs(repos) do
			self.repos[#self.repos + 1] = vim.tbl_extend("force", { repo }, conf)
		end
	end
end

function Packer:init()
	local packer_first_installed = nil
	local packer_install_directory = nvim_plugins_dir .. "/pack/packer/opt/packer.nvim"
	if fn.empty(fn.glob(packer_install_directory)) > 0 then
		packer_first_installed = fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			packer_install_directory,
		})
	end

	if not packer then
		api.nvim_command("packadd packer.nvim")
		packer = require("packer")
	end

	packer.init({ compile_path = packer_compiled })
	packer.reset()
	packer.startup(function(use)
		use({ "wbthomason/packer.nvim", opt = true })
		self:load_plugins()
		for _, repo in ipairs(self.repos) do
			use(repo)
		end
	end)

	if packer_first_installed then
		packer.sync()
	end

	if vim.fn.filereadable(packer_compiled) == 1 then
		require("_compiled")
	else
		assert("Missing packer compile file Run PackerCompile Or PackerInstall to fix")
	end
end

return Packer
