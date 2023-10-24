-- luacheck: globals vim
local debugger = {}
local conf = require("plugins.debugger.config")
local keymap = vim.api.nvim_set_keymap
local keymap_opts = { noremap = true, silent = true }

debugger["mfussenegger/nvim-dap"] = {
	config = conf.dap,
	keymap("n", "<F4>", '<cmd>lua require("dap").terminate()<cr>', keymap_opts),
	keymap("n", "<F5>", '<cmd>lua require("dap").continue()<cr>', keymap_opts),
	keymap("n", "<F9>", '<cmd>lua require("dap").toggle_breakpoint()<cr>', keymap_opts),
	keymap("n", "<F10>", '<cmd>lua require("dap").step_over()<cr>', keymap_opts),
	keymap("n", "<F11>", '<cmd>lua require("dap").step_into()<cr>', keymap_opts),
	keymap("n", "<F12>", '<cmd>lua require("dap").step_out()<cr>', keymap_opts),
}

debugger["rcarriga/nvim-dap-ui"] = {
	config = conf.dap_ui,
	requires = { "mfussenegger/nvim-dap" },
}

debugger["theHamsta/nvim-dap-virtual-text"] = {
	config = conf.dap_virtual_text,
	requires = { "mfussenegger/nvim-dap" },
}

return debugger
