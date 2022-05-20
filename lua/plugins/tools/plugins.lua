-- luacheck: globals vim
local tools = {}
local keymap = vim.api.nvim_set_keymap
local conf = require("plugins.tools.config")

tools["nvim-telescope/telescope.nvim"] = {
	module = "telescope",
	cmd = "Telescope",
	config = conf.telescope,
	requires = {
		{ "kyazdani42/nvim-web-devicons", opt = false },
		{ "nvim-lua/plenary.nvim", opt = false },
		{ "nvim-lua/popup.nvim", opt = false },
	},
	keymap(
		"n",
		"ff",
		"<cmd>lua require('plugins.tools.pickers').project_files()<cr>",
		{ noremap = true, silent = true }
	),
	keymap("n", "fs", "<cmd>lua require('plugins.tools.pickers').search()<cr>", { noremap = true, silent = true }),
	keymap("n", "bb", "<cmd>lua require('telescope.builtin').buffers()<cr>", { noremap = true, silent = true }),
	keymap("n", "fh", "<cmd>lua require('telescope.builtin').oldfiles()<cr>", { noremap = true, silent = true }),
	keymap(
		"n",
		"fp",
		"<cmd>lua require'telescope'.extensions.project.project{ display_type = 'full' }<CR>",
		{ noremap = true, silent = true }
	),
}

tools["nvim-telescope/telescope-frecency.nvim"] = {
	after = "telescope-fzf-native.nvim",
	requires = { "tami5/sqlite.lua" },
}
tools["nvim-telescope/telescope-fzf-native.nvim"] = { after = "telescope.nvim", run = "make" }
tools["nvim-telescope/telescope-live-grep-raw.nvim"] = { after = "telescope-frecency.nvim" }
tools["nvim-telescope/telescope-project.nvim"] = { after = "telescope-live-grep-raw.nvim" }
tools["notjedi/nvim-rooter.lua"] = { after = "telescope-project.nvim", config = conf.rooter }

tools["airblade/vim-gitgutter"] = {
	keymap("n", "gn", "<Plug>(GitGutterNextHunk)", { noremap = true, silent = true }),
	keymap("n", "gp", "<Plug>(GitGutterPrevHunk)", { noremap = true, silent = true }),
	keymap("n", "gf", ":GitGutterFold<CR>", { noremap = true, silent = true }),

	-- Refresh gitgutter signs
	vim.cmd([[augroup GitGutterRefresh]]),
	vim.cmd([[autocmd! * <buffer>]]),
	vim.cmd([[autocmd BufWritePre <buffer> :GitGutter]]),
	vim.cmd([[augroup END]]),
}

tools["dstein64/vim-startuptime"] = {
	cmd = "StartupTime",
	keymap("n", "<C-c>s", ":StartupTime<CR>", { noremap = true, silent = true }),
}

tools["TimUntersberger/neogit"] = {
	requires = {
		{ "nvim-lua/plenary.nvim", opt = false },
		{ "sindrets/diffview.nvim" },
	},
	config = conf.neogit,
	keymap("n", "gs", '<cmd>lua require("neogit").open()<CR>', { noremap = true, silent = true }),
}

tools["aserowy/tmux.nvim"] = {
	config = conf.tmux,
	keymap("n", "<A-h>", '<cmd>lua require("tmux").move_left()<cr>', { noremap = true, silent = true }),
	keymap("n", "<A-j>", '<cmd>lua require("tmux").move_bottom()<cr>', { noremap = true, silent = true }),
	keymap("n", "<A-k>", '<cmd> lua require("tmux").move_top()<cr>', { noremap = true, silent = true }),
	keymap("n", "<A-l>", '<cmd>lua require("tmux").move_right()<cr>', { noremap = true, silent = true }),

	keymap("n", "<Left>", '<cmd>lua require("tmux").resize_left()<cr>', { noremap = true, silent = true }),
	keymap("n", "<Down>", '<cmd>lua require("tmux").resit_bottom()<cr>', { noremap = true, silent = true }),
	keymap("n", "<Right>", '<cmd>lua require("tmux").resize_right()<cr>', { noremap = true, silent = true }),
	keymap("n", "<Up>", '<cmd> lua require("tmux").resize_top()<cr>', { noremap = true, silent = true }),
}

tools["akinsho/toggleterm.nvim"] = {
	tag = "v1.*",
	config = conf.toggleterm,
	keymap("n", "<C-\\>", '<Cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true }),
	keymap("i", "<C-\\>", '<Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true }),
}
return tools
