-- luacheck: globals vim
local editor = {}
local keymap = vim.api.nvim_set_keymap
local conf = require("plugins.editor.config")

editor["nvim-treesitter/nvim-treesitter"] = {
	run = ":TSUpdate",
	event = "BufRead",
	config = conf.nvim_treesitter,
}

editor["p00f/nvim-ts-rainbow"] = {
	after = "nvim-treesitter",
	event = "BufRead",
}
editor["nvim-treesitter/nvim-treesitter-textobjects"] = { after = "nvim-treesitter" }
editor["JoosepAlviste/nvim-ts-context-commentstring"] = { after = "nvim-treesitter" }
editor["windwp/nvim-spectre"] = {
	requires = {
		{ "kyazdani42/nvim-web-devicons", opt = false },
		{ "nvim-lua/plenary.nvim", opt = false },
	},
	config = conf.spectre,
	keymap("n", "fr", "<cmd>lua require('spectre').open()<CR>", { noremap = true, silent = true }),
	keymap(
		"n",
		"fw",
		"<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
		{ noremap = true, silent = true }
	),
}

editor["nvim-orgmode/orgmode"] = {
	after = "nvim-treesitter",
	config = conf.orgmode,
}

editor["akinsho/org-bullets.nvim"] = {
	after = "orgmode",
	config = function()
		require("org-bullets").setup({
			symbols = { "🐅 ", "🦅 ", "🦣 ", "🦬 ", "🐂 ", "🐗 ", "🐖 ", "🐏 ", "🐔 ", "🦐 " },
		})
	end,
}

editor["lukas-reineke/headlines.nvim"] = {
	after = "org-bullets.nvim",
	config = function()
		require("headlines").setup()
	end,
}

editor["rhysd/accelerated-jk"] = {
	event = "BufWinEnter",
	keymap("n", "k", "<Plug>(accelerated_jk_gk)", { noremap = true, silent = true }),
	keymap("n", "j", "<Plug>(accelerated_jk_gj)", { noremap = true, silent = true }),
}

editor["phaazon/hop.nvim"] = {
	branch = "v1",
	event = "BufReadPost",
	config = function()
		require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
	end,
	vim.api.nvim_set_keymap("n", ".", "<cmd>lua require'hop'.hint_char1()<cr>", {}),
	vim.api.nvim_set_keymap("n", ",", "<cmd>lua require'hop'.hint_words()<cr>", {}),
}

editor["edluffy/specs.nvim"] = {
	event = "CursorMoved",
	config = conf.specs,
	vim.api.nvim_set_keymap("n", "<CR>", ':lua require("specs").show_specs()<CR>', { noremap = true, silent = true }),
	-- You can even bind it to search jumping and more, example:
	vim.api.nvim_set_keymap("n", "n", 'n:lua require("specs").show_specs()<CR>', { noremap = true, silent = true }),
	vim.api.nvim_set_keymap("n", "N", 'N:lua require("specs").show_specs()<CR>', { noremap = true, silent = true }),
}

editor["romainl/vim-cool"] = { event = { "CursorMoved", "InsertEnter" } }
editor["terrortylor/nvim-comment"] = { opt = false, config = conf.comment }
editor["karb94/neoscroll.nvim"] = { event = "BufReadPost", config = conf.neoscroll }
return editor
