-- luacheck: globals vim
local config = {}

function config.alpha()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")

	dashboard.section.header.val = {
		[[                                                  ]],
		[[                                                  ]],
		[[                                                  ]],
		[[                                                  ]],
		[[                                                  ]],
		[[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
		[[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
		[[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
		[[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
		[[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
		[[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
		[[                                                  ]],
		[[                    By Jerry.                     ]],
	}
	dashboard.section.buttons.val = {
		dashboard.button(
			"p",
			"  Find project",
			"<cmd>lua require'telescope'.extensions.project.project{ display_type = 'full' }<CR>"
		),
		dashboard.button("f", "  Find file", "<cmd>lua require('plugins.tools.pickers').project_files()<CR>"),
		dashboard.button("t", "  Find text", "<cmd>lua require('plugins.tools.pickers').search()<CR>"),
		dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
		dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
		dashboard.button("q", "  Quit vim", ":qa<CR>"),
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

function config.colorizer()
	require("colorizer").setup({
		"*",
	}, { css = true })
end

function config.lualine()
	vim.cmd([[packadd nvim-gps]])
	local gps = require("nvim-gps")

	require("lualine").setup({
		sections = {
			lualine_a = { "mode", "buffers" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				"filename",
				"lsp_progress",
				{ gps.get_location, cond = gps.is_available },
			},
			lualine_x = { "encoding", "fileformat", "filetype", "filesize" },
			lualine_y = { "progress" },
			lualine_z = { "location", "tabs" },
		},
		options = {
			theme = "palenight",
			component_separators = { left = "|", right = "|" },
			section_separators = { left = "", right = "" },
		},
	})
end

function config.nvim_tree()
	vim.g.nvim_tree_icons = {
		["default"] = "",
		["symlink"] = "",
		["git"] = {
			["unstaged"] = "",
			["staged"] = "",
			["unmerged"] = "שׂ",
			["renamed"] = "",
			["untracked"] = "ﲉ",
			["deleted"] = "",
			["ignored"] = "",
		},
		["folder"] = {
			["arrow_open"] = "",
			["arrow_closed"] = "",
			["default"] = "",
			["open"] = "",
			["empty"] = "",
			["empty_open"] = "",
			["symlink"] = "",
			["symlink_open"] = "",
		},
	}

	require("nvim-tree").setup({
		auto_reload_on_write = true,
		disable_netrw = false,
		hijack_cursor = false,
		hijack_netrw = true,
		hijack_unnamed_buffer_when_opening = false,
		ignore_buffer_on_setup = false,
		open_on_setup = false,
		open_on_setup_file = false,
		open_on_tab = false,
		sort_by = "name",
		update_cwd = true,
		view = {
			width = 30,
			height = 30,
			hide_root_folder = false,
			side = "left",
			preserve_window_proportions = false,
			number = false,
			relativenumber = false,
			signcolumn = "yes",
			mappings = {
				custom_only = false,
				list = {
					-- user mappings go here
					{ key = "s", action = "" },
				},
			},
		},
		renderer = {
			indent_markers = {
				enable = false,
				icons = {
					corner = "└ ",
					edge = "│ ",
					none = "  ",
				},
			},
			icons = {
				webdev_colors = true,
			},
		},
		hijack_directories = {
			enable = true,
			auto_open = true,
		},
		update_focused_file = {
			enable = true,
			update_cwd = true,
			ignore_list = {},
		},
		ignore_ft_on_setup = {},
		system_open = {
			cmd = "",
			args = {},
		},
		diagnostics = {
			enable = false,
			show_on_dirs = false,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		filters = {
			dotfiles = false,
			custom = {},
			exclude = {},
		},
		git = {
			enable = true,
			ignore = true,
			timeout = 400,
		},
		actions = {
			use_system_clipboard = true,
			change_dir = {
				enable = true,
				global = false,
				restrict_above_cwd = false,
			},
			open_file = {
				quit_on_open = false,
				resize_window = false,
				window_picker = {
					enable = true,
					chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
					exclude = {
						filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
						buftype = { "nofile", "terminal", "help" },
					},
				},
			},
		},
		trash = {
			cmd = "trash",
			require_confirm = true,
		},
		log = {
			enable = false,
			truncate = false,
			types = {
				all = false,
				config = false,
				copy_paste = false,
				diagnostics = false,
				git = false,
				profile = false,
			},
		},
	})
end

function config.nvim_bufferline()
	require("bufferline").setup({
		options = {
			number = "none",
			modified_icon = "✥",
			buffer_close_icon = "",
			left_trunc_marker = "",
			right_trunc_marker = "",
			max_name_length = 14,
			max_prefix_length = 13,
			tab_size = 20,
			show_buffer_close_icons = true,
			show_buffer_icons = true,
			show_tab_indicators = true,
			diagnostics = "nvim_lsp",
			always_show_bufferline = true,
			separator_style = "thin",
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "center",
					padding = 1,
				},
			},
		},
	})
end

return config
