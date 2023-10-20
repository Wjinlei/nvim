-- luacheck: globals vim
local config = {}

function config.dap()
	local dap = require("dap")
	local cpp_adapter_config = require("plugins.debugger.adapters.cpp")
	local cpp_dap_config = require("plugins.debugger.dap.cpp")

	dap.adapters.cppdbg = cpp_adapter_config

	dap.configurations.cpp = cpp_dap_config
	dap.configurations.c = dap.configurations.cpp
	dap.configurations.rust = dap.configurations.cpp

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
