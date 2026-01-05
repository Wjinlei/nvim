-- luacheck: globals vim
local tools = {}
local conf = require("plugins.tools.config")
local keymap = vim.api.nvim_set_keymap
local keymap_opts = { noremap = true, silent = true }

tools["ibhagwan/fzf-lua"] = {
	config = conf.fzf_lua,
	requires = 'nvim-tree/nvim-web-devicons',
	keymap("n", "fp", '<cmd>lua require("fzf-lua").grep_project()<CR>', keymap_opts),
	keymap("n", "ff", '<cmd>lua require("fzf-lua").files()<CR>', keymap_opts),
	keymap("n", "fs", '<cmd>lua require("fzf-lua").live_grep_native()<CR>', keymap_opts),
	keymap("n", "fh", '<cmd>lua require("fzf-lua").oldfiles()<CR>', keymap_opts),
	keymap("n", "bb", '<cmd>lua require("fzf-lua").buffers()<CR>', keymap_opts),
	keymap("n", "fg", '<cmd>lua require("fzf-lua").git_status()<CR>', keymap_opts),
}

tools["airblade/vim-gitgutter"] = {
	keymap("n", "gn", "<Plug>(GitGutterNextHunk)", keymap_opts),
	keymap("n", "gp", "<Plug>(GitGutterPrevHunk)", keymap_opts),
	keymap("n", "gf", ":GitGutterFold<CR>", keymap_opts),
	keymap("n", "gl", ":GitGutter<CR>", keymap_opts),
	vim.cmd([[
augroup GitGutterRefresh
autocmd! * <buffer>
autocmd DiffUpdated <buffer> :GitGutter
augroup END
        ]]),
}

tools["dstein64/vim-startuptime"] = {
	cmd = "StartupTime",
	keymap("n", "<C-c>s", ":StartupTime<CR>", keymap_opts),
}

tools["NeogitOrg/neogit"] = {
	requires = {
		{ "nvim-lua/plenary.nvim", opt = false },
	},
	config = conf.neogit,
	keymap("n", "gs", '<cmd>lua require("neogit").open()<CR>', keymap_opts),
}

tools["f-person/git-blame.nvim"] = {
	config = conf.gitblame,
	keymap("n", "gb", ":GitBlameOpenCommitURL<CR>", keymap_opts),
}

tools["aserowy/tmux.nvim"] = {
	config = conf.tmux,
	keymap("n", "<Left>", '<cmd>lua require("tmux").resize_left()<cr>', keymap_opts),
	keymap("n", "<Down>", '<cmd>lua require("tmux").resize_bottom()<cr>', keymap_opts),
	keymap("n", "<Right>", '<cmd>lua require("tmux").resize_right()<cr>', keymap_opts),
	keymap("n", "<Up>", '<cmd> lua require("tmux").resize_top()<cr>', keymap_opts),
	keymap("n", "<A-h>", '<cmd>lua require("tmux").move_left()<cr>', keymap_opts),
	keymap("n", "<A-j>", '<cmd>lua require("tmux").move_bottom()<cr>', keymap_opts),
	keymap("n", "<A-k>", '<cmd> lua require("tmux").move_top()<cr>', keymap_opts),
	keymap("n", "<A-l>", '<cmd>lua require("tmux").move_right()<cr>', keymap_opts),
}

return tools
