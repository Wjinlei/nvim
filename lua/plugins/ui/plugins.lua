-- luacheck: globals vim
local ui = {}
local keymap = vim.api.nvim_set_keymap
local conf = require("plugins.ui.config")

ui["dracula/vim"] = {
	as = "dracula",
	config = function()
		vim.api.nvim_command([[ colorscheme dracula ]])
	end,
}

ui["goolord/alpha-nvim"] = {
	opt = true,
	event = "BufWinEnter",
	config = conf.alpha,
	requires = "kyazdani42/nvim-web-devicons",
	-- keymap("n", "ta", "<cmd>Alpha<cr>", { noremap = true, silent = true }),
}

ui["RRethy/vim-illuminate"] = {
	after = "nvim-treesitter",
	config = function()
		vim.api.nvim_command([[ hi illuminatedWord cterm=undercurl gui=undercurl ]])
	end,
}

--------------------------------------------------------
-- deprecated -- https://github.com/SmiteshP/nvim-navic
--------------------------------------------------------
-- ui["SmiteshP/nvim-gps"] = {
-- 	after = "nvim-treesitter",
-- 	config = conf.nvim_gps,
-- 	requires = "nvim-treesitter/nvim-treesitter",
-- }

ui["SmiteshP/nvim-navic"] = {
	after = "nvim-lspconfig",
	config = conf.nvim_navic,
	requires = "neovim/nvim-lspconfig",
}

ui["nvim-lualine/lualine.nvim"] = {
	as = "lualine",
	after = "lualine-lsp-progress",
	config = conf.lualine,
}

ui["arkav/lualine-lsp-progress"] = { after = "nvim-navic" }

ui["kyazdani42/nvim-tree.lua"] = {
	cmd = { "NvimTreeToggle" },
	requires = { "kyazdani42/nvim-web-devicons" },
	config = conf.nvim_tree,
	keymap("n", "tt", "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true }),
}

ui["akinsho/bufferline.nvim"] = {
	tag = "*",
	config = conf.nvim_bufferline,
	requires = 'nvim-tree/nvim-web-devicons',
}

ui["norcalli/nvim-colorizer.lua"] = { as = "colorizer", config = conf.colorizer }

ui["gelguy/wilder.nvim"] = {
	config = conf.wilder,
	requires = { "kyazdani42/nvim-web-devicons" },
}

return ui
