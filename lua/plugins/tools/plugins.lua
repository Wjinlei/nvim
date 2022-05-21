-- luacheck: globals vim
local tools = {}
local conf = require("plugins.tools.config")
local keymap = vim.api.nvim_set_keymap
local keymap_opts = { noremap = true, silent = true }

tools["nvim-telescope/telescope.nvim"] = {
	module = "telescope",
	cmd = "Telescope",
	config = conf.telescope,
	requires = {
		{ "kyazdani42/nvim-web-devicons", opt = false },
		{ "nvim-lua/plenary.nvim", opt = false },
		{ "nvim-lua/popup.nvim", opt = false },
	},
	keymap("n", "ff", "<cmd>lua require('plugins.tools.pickers').project_files()<cr>", keymap_opts),
	keymap("n", "fg", "<cmd>lua require('plugins.tools.pickers').project_change_files()<cr>", keymap_opts),
	keymap("n", "fs", "<cmd>lua require('plugins.tools.pickers').search()<cr>", keymap_opts),
	keymap("n", "bb", "<cmd>lua require('telescope.builtin').buffers()<cr>", keymap_opts),
	keymap("n", "fh", "<cmd>lua require('telescope.builtin').oldfiles()<cr>", keymap_opts),
	keymap("n", "fp", ":lua require'telescope'.extensions.project.project{ display_type = 'full' }<CR>", keymap_opts),
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
	keymap("n", "gn", "<Plug>(GitGutterNextHunk)", keymap_opts),
	keymap("n", "gp", "<Plug>(GitGutterPrevHunk)", keymap_opts),
	keymap("n", "gf", ":GitGutterFold<CR>", keymap_opts),
	keymap("n", "gl", ":GitGutter<CR>", keymap_opts),
	vim.cmd([[
augroup GitGutterRefresh
autocmd! * <buffer>
autocmd DiffUpdated * :GitGutter
augroup END
        ]]),
}

tools["dstein64/vim-startuptime"] = {
	cmd = "StartupTime",
	keymap("n", "<C-c>s", ":StartupTime<CR>", keymap_opts),
}

tools["TimUntersberger/neogit"] = {
	requires = {
		{ "nvim-lua/plenary.nvim", opt = false },
	},
	config = conf.neogit,
	keymap("n", "gs", '<cmd>lua require("neogit").open()<CR>', keymap_opts),
}

tools["aserowy/tmux.nvim"] = {
	config = conf.tmux,
	keymap("n", "<Left>", '<cmd>lua require("tmux").resize_left()<cr>', keymap_opts),
	keymap("n", "<Down>", '<cmd>lua require("tmux").resit_bottom()<cr>', keymap_opts),
	keymap("n", "<Right>", '<cmd>lua require("tmux").resize_right()<cr>', keymap_opts),
	keymap("n", "<Up>", '<cmd> lua require("tmux").resize_top()<cr>', keymap_opts),
	keymap("n", "<A-h>", '<cmd>lua require("tmux").move_left()<cr>', keymap_opts),
	keymap("n", "<A-j>", '<cmd>lua require("tmux").move_bottom()<cr>', keymap_opts),
	keymap("n", "<A-k>", '<cmd> lua require("tmux").move_top()<cr>', keymap_opts),
	keymap("n", "<A-l>", '<cmd>lua require("tmux").move_right()<cr>', keymap_opts),
}

tools["akinsho/toggleterm.nvim"] = {
	tag = "v1.*",
	config = conf.toggleterm,
	keymap("n", "<C-\\>", '<Cmd>exe v:count1 . "ToggleTerm"<CR>', keymap_opts),
	keymap("i", "<C-\\>", '<Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>', keymap_opts),
}
return tools
