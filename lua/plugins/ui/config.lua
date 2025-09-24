-- luacheck: globals vim
local config = {}

function config.alpha()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")

	dashboard.section.header.val = {
		[[                                                  ]],
		[[                         `..`                     ]],
		[[                       ````+ `.`                  ]],
		[[                   /o:``   :+ ``                  ]],
		[[               .+//dho......y/..`                 ]],
		[[               `sdddddhysso+h` ``                 ]],
		[[                 /ddd+`..` +. .`                  ]],
		[[                -hos+    `.:```                   ]],
		[[              `./dddyo+//osso/:`                  ]],
		[[            `/o++dddddddddddddod-                 ]],
		[[           `// -y+:sdddddsddsy.dy                 ]],
		[[               /o   `..```h+`y+/h+`               ]],
		[[               .s       `++``o:  ``               ]],
		[[                       `:- `:-                    ]],
		[[                                                  ]],
		[[    CENTAUR VIM - Enjoy Programming & Writing     ]],
	}
	dashboard.section.buttons.val = {
		dashboard.button(
			"fp",
			"  Find project",
			"<cmd>lua require'telescope'.extensions.project.project{ display_type = 'full' }<CR>"
		),
		dashboard.button("ff", "󰈞  Find file", "<cmd>lua require('plugins.tools.pickers').project_files()<CR>"),
		dashboard.button("fs", "󱎸  Find text", "<cmd>lua require('plugins.tools.pickers').search()<CR>"),
		dashboard.button("fh", "  Recently used files", ":Telescope oldfiles <CR>"),
		dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
		dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
		dashboard.button("q", "󰗼  Quit vim", ":qa<CR>"),
	}

	dashboard.section.footer.val = function()
		return "Code out efficiency."
	end

	dashboard.section.header.opts.hl = "Include"
	dashboard.section.buttons.opts.hl = "Keyword"
	dashboard.section.footer.opts.hl = "Type"
	dashboard.opts.opts.noautocmd = true
	alpha.setup(dashboard.opts)
end

--[[
function config.nvim_gps()
	require("nvim-gps").setup({
		disable_icons = false, -- Setting it to true will disable all icons
		icons = {
			["class-name"] = " ", -- Classes and class-like objects
			["function-name"] = " ", -- Functions
			["method-name"] = " ", -- Methods (functions inside class-like objects)
			["container-name"] = "⛶ ", -- Containers (example: lua tables)
			["tag-name"] = "炙", -- Tags (example: html tags)
		},
		languages = {
			-- You can disable any language individually here
			["c"] = true,
			["cpp"] = true,
			["go"] = true,
			["javascript"] = true,
			["lua"] = true,
			["python"] = true,
			["rust"] = true,
		},
		separator = " > ",
		-- limit for amount of context shown
		-- 0 means no limit
		depth = 0,

		-- indicator used when context hits depth limit
		depth_limit_indicator = "..",
	})
end
--]]

function config.nvim_navic()
	require("nvim-navic").setup({
		icons = {
			File = " ",
			Module = " ",
			Namespace = " ",
			Package = " ",
			Class = " ",
			Method = " ",
			Property = " ",
			Field = " ",
			Constructor = " ",
			Enum = " ",
			Interface = " ",
			Function = " ",
			Variable = " ",
			Constant = " ",
			String = " ",
			Number = " ",
			Boolean = " ",
			Array = " ",
			Object = " ",
			Key = " ",
			Null = " ",
			EnumMember = " ",
			Struct = " ",
			Event = " ",
			Operator = " ",
			TypeParameter = " ",
		},
		lsp = {
			auto_attach = true,
			preference = { 'vue_ls', 'vtsls' },
		},
		highlight = true,
		separator = " > ",
		depth_limit = 0,
		depth_limit_indicator = "..",
		safe_output = true,
		click = false,
	})
end

function config.colorizer()
	require("colorizer").setup({
		"*",
	}, { css = true })
end

function config.lualine()
	vim.cmd([[packadd nvim-navic]])
	local navic = require("nvim-navic")

	require("lualine").setup({
		sections = {
			lualine_a = { "mode", "buffers" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				"filename",
				"lsp_progress",
				{
					function()
						return navic.get_location()
					end,
					cond = function()
						return navic.is_available()
					end,
				},
			},
			lualine_x = { "encoding", "filetype", "filesize" },
			lualine_y = { "progress" },
			lualine_z = { "location", "lsp_status" },
		},
		options = {
			theme = "palenight",
			component_separators = { left = "|", right = "|" },
			section_separators = { left = "", right = "" },
		},
	})
end

function config.nvim_tree()
	require("nvim-tree").setup({
		view = {
			width = 30,
		},

		on_attach = function(bufnr)
			local api = require("nvim-tree.api")
			local function opts(desc)
				return {
					desc = "nvim-tree: " .. desc,
					buffer = bufnr,
					noremap = true,
					silent = true,
					nowait = true,
				}
			end
			-- default mappings
			api.config.mappings.default_on_attach(bufnr)
			-- custom mappings
			vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
		end,
	})
end

function config.nvim_bufferline()
	require("bufferline").setup{}
end

function config.wilder()
	local wilder = require("wilder")
	wilder.setup({
		modes = { ":", "/", "?" },
		next_key = "<C-j>",
		previous_key = "<C-k>",
	})
	wilder.set_option("use_python_remote_plugin", 0)
	wilder.set_option("pipeline", {
		wilder.branch(wilder.cmdline_pipeline(), wilder.search_pipeline()),
	})
	wilder.set_option(
		"renderer",
		wilder.renderer_mux({
			[":"] = wilder.popupmenu_renderer({
				highlighter = wilder.basic_highlighter(),
				left = { " ", wilder.popupmenu_devicons() },
				right = { " ", wilder.popupmenu_scrollbar() },
			}),
			["/"] = wilder.wildmenu_renderer({
				highlighter = wilder.basic_highlighter(),
			}),
		})
	)
end

return config
