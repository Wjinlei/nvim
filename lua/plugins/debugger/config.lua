-- luacheck: globals vim
local config = {}

function config.dap()
	local dap = require("dap")
	local codelldb_adapter = require("plugins.debugger.adapters.codelldb")
	local codelldb_conf = require("plugins.debugger.configs.codelldb")

	-- Adapter
	dap.adapters.codelldb = codelldb_adapter

	-- Dap Configs
	dap.configurations.cpp = codelldb_conf
	dap.configurations.c = codelldb_conf
	dap.configurations.rust = codelldb_conf

	local dap_breakpoint = {
		error = {
			text = "🛑",
			texthl = "DapBreakpoint",
			linehl = "DapBreakpoint",
			numhl = "DapBreakpoint",
		},
		condition = {
			text = "󰟃",
			texthl = "DapBreakpoint",
			linehl = "DapBreakpoint",
			numhl = "DapBreakpoint",
		},
		rejected = {
			text = "󰃤",
			texthl = "DapBreakpint",
			linehl = "DapBreakpoint",
			numhl = "DapBreakpoint",
		},
		logpoint = {
			text = "",
			texthl = "DapLogPoint",
			linehl = "DapLogPoint",
			numhl = "DapLogPoint",
		},
		stopped = {
			text = "󰜴",
			texthl = "DapStopped",
			linehl = "DapStopped",
			numhl = "DapStopped",
		},
	}

	vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
	vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
	vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
	vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
	vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
end

function config.dap_ui()
	local dap, dapui = require("dap"), require("dapui")

	dapui.setup({
		element_mappings = {
			scopes = {
				edit = "e",
				repl = "r",
			},
			watches = {
				edit = "e",
				repl = "r",
			},
			stacks = {
				open = "g",
			},
			breakpoints = {
				open = "g",
				toggle = "b",
			},
		},

		layouts = {
			{
				elements = {
					"scopes",
					"stacks",
					"breakpoints",
					"watches",
				},
				size = 0.2, -- 40 columns
				position = "left",
			},
			{
				elements = {
					"repl",
				},
				size = 0.25, -- 25% of total lines
				position = "bottom",
			},
			{
				elements = {
					"console",
				},
				size = 0.2,
				position = "right",
			},
		},

		floating = {
			max_height = nil, -- These can be integers or a float between 0 and 1.
			max_width = nil, -- Floats will be treated as percentage of your screen.
			border = "rounded", -- Border style. Can be "single", "double" or "rounded"
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
	})

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end

	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end

	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

function config.dap_virtual_text()
	require("nvim-dap-virtual-text").setup()
end

return config
