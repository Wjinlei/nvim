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

ui["SmiteshP/nvim-gps"] = {
	after = "nvim-treesitter",
	config = conf.nvim_gps,
	requires = "nvim-treesitter/nvim-treesitter",
}

ui["nvim-lualine/lualine.nvim"] = {
	as = "lualine",
	after = "lualine-lsp-progress",
	config = conf.lualine,
}

ui["arkav/lualine-lsp-progress"] = { after = "nvim-gps" }

ui["kyazdani42/nvim-tree.lua"] = {
	cmd = { "NvimTreeToggle" },
	requires = { "kyazdani42/nvim-web-devicons" },
	config = conf.nvim_tree,
	keymap("n", "tt", "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true }),
}

ui["akinsho/bufferline.nvim"] = {
	tag = "*",
	event = "BufRead",
	config = conf.nvim_bufferline,
}

ui["norcalli/nvim-colorizer.lua"] = { as = "colorizer", config = conf.colorizer }
return ui
