-- luacheck: globals vim
local config = {}

function config.lspconfig()
	require("plugins.completion.lspconfig")
end

function config.rust_tools()
	local rt = require("rust-tools")
	local opts = {
		-- all the opts to send to nvim-lspconfig
		-- these override the defaults set by rust-tools.nvim
		-- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
		server = {
			-- standalone file support
			-- setting it to false may improve startup time
			standalone = true,
			on_attach = function(_, bufnr)
				require("plugins.completion.on_attach").on_attach(_, bufnr)
				vim.keymap.set("n", "<A-c>", rt.open_cargo_toml.open_cargo_toml, { buffer = bufnr })
				vim.keymap.set("n", "r", rt.runnables.runnables, { buffer = bufnr })
				-- hover_range功能目前好像有Bug https://github.com/simrat39/rust-tools.nvim/issues/235
				-- vim.keymap.set("v", "<A-d>", rt.hover_range.hover_range, { buffer = bufnr })
				vim.keymap.set("n", "<A-d>", rt.hover_actions.hover_actions, { buffer = bufnr })
				vim.keymap.set("n", "<A-e>", rt.expand_macro.expand_macro, { buffer = bufnr })
			end,
		}, -- rust-analyzer options

		tools = { -- rust-tools options
			-- how to execute terminal commands
			-- options right now: termopen / quickfix
			executor = require("rust-tools/executors").termopen,

			-- callback to execute once rust-analyzer is done initializing the workspace
			-- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
			on_initialized = nil,

			-- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
			reload_workspace_from_cargo_toml = true,

			-- These apply to the default RustSetInlayHints command
			inlay_hints = {
				-- automatically set inlay hints (type hints)
				-- default: true
				auto = true,

				-- Only show inlay hints for the current line
				only_current_line = false,

				-- whether to show parameter hints with the inlay hints or not
				-- default: true
				show_parameter_hints = true,

				-- prefix for parameter hints
				-- default: "<-"
				parameter_hints_prefix = "<- ",

				-- prefix for all the other hints (type, chaining)
				-- default: "=>"
				other_hints_prefix = "=> ",

				-- whether to align to the length of the longest line in the file
				max_len_align = false,

				-- padding from the left if max_len_align is true
				max_len_align_padding = 1,

				-- whether to align to the extreme right or not
				right_align = false,

				-- padding from the right if right_align is true
				right_align_padding = 7,

				-- The color of the hints
				highlight = "Comment",
			},

			-- options same as lsp hover / vim.lsp.util.open_floating_preview()
			hover_actions = {

				-- the border that is used for the hover window
				-- see vim.api.nvim_open_win()
				border = {
					{ "╭", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "╮", "FloatBorder" },
					{ "│", "FloatBorder" },
					{ "╯", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "╰", "FloatBorder" },
					{ "│", "FloatBorder" },
				},

				-- whether the hover action window gets automatically focused
				-- default: false
				auto_focus = true,
			},

			-- settings for showing the crate graph based on graphviz and the dot
			-- command
			crate_graph = {
				-- Backend used for displaying the graph
				-- see: https://graphviz.org/docs/outputs/
				-- default: x11
				backend = "x11",
				-- where to store the output, nil for no output stored (relative
				-- path from pwd)
				-- default: nil
				output = nil,
				-- true for all crates.io and external crates, false only the local
				-- crates
				-- default: true
				full = true,

				-- List of backends found on: https://graphviz.org/docs/outputs/
				-- Is used for input validation and autocompletion
				-- Last updated: 2021-08-26
				enabled_graphviz_backends = {
					"bmp",
					"cgimage",
					"canon",
					"dot",
					"gv",
					"xdot",
					"xdot1.2",
					"xdot1.4",
					"eps",
					"exr",
					"fig",
					"gd",
					"gd2",
					"gif",
					"gtk",
					"ico",
					"cmap",
					"ismap",
					"imap",
					"cmapx",
					"imap_np",
					"cmapx_np",
					"jpg",
					"jpeg",
					"jpe",
					"jp2",
					"json",
					"json0",
					"dot_json",
					"xdot_json",
					"pdf",
					"pic",
					"pct",
					"pict",
					"plain",
					"plain-ext",
					"png",
					"pov",
					"ps",
					"ps2",
					"psd",
					"sgi",
					"svg",
					"svgz",
					"tga",
					"tiff",
					"tif",
					"tk",
					"vml",
					"vmlz",
					"wbmp",
					"webp",
					"xlib",
					"x11",
				},
			},
		},

		-- Debugging stuff
		dap = {
			adapter = {
				type = "executable",
				command = "lldb-vscode",
				name = "rt_lldb",
			},
		},
	}
	rt.setup(opts)
end

function config.lightbulb()
	vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
end

function config.aerial()
	-- Call the setup function to change the default behavior
	require("aerial").setup({
		-- Priority list of preferred backends for aerial.
		-- This can be a filetype map (see :help aerial-filetype-map)
		backends = { "lsp", "treesitter", "markdown", "man" },

		layout = {
			-- These control the width of the aerial window.
			-- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			-- min_width and max_width can be a list of mixed types.
			-- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
			max_width = { 40, 0.2 },
			width = nil,
			min_width = 10,

			-- key-value pairs of window-local options for aerial window (e.g. winhl)
			win_opts = {},

			-- Determines the default direction to open the aerial window. The 'prefer'
			-- options will open the window in the other direction *if* there is a
			-- different buffer in the way of the preferred direction
			-- Enum: prefer_right, prefer_left, right, left, float
			default_direction = "prefer_right",

			-- Determines where the aerial window will be opened
			--   edge   - open aerial at the far right/left of the editor
			--   window - open aerial to the right/left of the current window
			placement = "window",
		},

		-- Determines how the aerial window decides which buffer to display symbols for
		--   window - aerial window will display symbols for the buffer in the window from which it was opened
		--   global - aerial window will display symbols for the current window
		attach_mode = "window",

		-- List of enum values that configure when to auto-close the aerial window
		--   unfocus       - close aerial when you leave the original source window
		--   switch_buffer - close aerial when you change buffers in the source window
		--   unsupported   - close aerial when attaching to a buffer that has no symbol source
		close_automatic_events = {},

		-- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
		-- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
		-- Additionally, if it is a string that matches "aerial.<name>",
		-- it will use the mapping at require("aerial.action").<name>
		-- Set to `false` to remove a keymap
		keymaps = {
			["?"] = "actions.show_help",
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.jump",
			["<2-LeftMouse>"] = "actions.jump",
			["<C-v>"] = "actions.jump_vsplit",
			["<C-s>"] = "actions.jump_split",
			["p"] = "actions.scroll",
			["<C-j>"] = "actions.down_and_scroll",
			["<C-k>"] = "actions.up_and_scroll",
			["{"] = "actions.prev",
			["}"] = "actions.next",
			["[["] = "actions.prev_up",
			["]]"] = "actions.next_up",
			["q"] = "actions.close",
			["o"] = "actions.tree_toggle",
			["za"] = "actions.tree_toggle",
			["O"] = "actions.tree_toggle_recursive",
			["zA"] = "actions.tree_toggle_recursive",
			["l"] = "actions.tree_open",
			["zo"] = "actions.tree_open",
			["L"] = "actions.tree_open_recursive",
			["zO"] = "actions.tree_open_recursive",
			["h"] = "actions.tree_close",
			["zc"] = "actions.tree_close",
			["H"] = "actions.tree_close_recursive",
			["zC"] = "actions.tree_close_recursive",
			["zr"] = "actions.tree_increase_fold_level",
			["zR"] = "actions.tree_open_all",
			["zm"] = "actions.tree_decrease_fold_level",
			["zM"] = "actions.tree_close_all",
			["zx"] = "actions.tree_sync_folds",
			["zX"] = "actions.tree_sync_folds",
		},

		-- When true, don't load aerial until a command or function is called
		-- Defaults to true, unless `on_attach` is provided, then it defaults to false
		lazy_load = false,

		-- Disable aerial on files with this many lines
		disable_max_lines = 10000,

		-- Disable aerial on files this size or larger (in bytes)
		disable_max_size = 2000000, -- Default 2MB

		-- A list of all symbols to display. Set to false to display all symbols.
		-- This can be a filetype map (see :help aerial-filetype-map)
		-- To see all available values, see :help SymbolKind
		filter_kind = {
			"Class",
			"Constructor",
			"Enum",
			"Function",
			"Interface",
			"Module",
			"Method",
			"Struct",
		},

		-- Determines line highlighting mode when multiple splits are visible.
		-- split_width   Each open window will have its cursor location marked in the
		--               aerial buffer. Each line will only be partially highlighted
		--               to indicate which window is at that location.
		-- full_width    Each open window will have its cursor location marked as a
		--               full-width highlight in the aerial buffer.
		-- last          Only the most-recently focused window will have its location
		--               marked in the aerial buffer.
		-- none          Do not show the cursor locations in the aerial window.
		highlight_mode = "split_width",

		-- Highlight the closest symbol if the cursor is not exactly on one.
		highlight_closest = true,

		-- Highlight the symbol in the source buffer when cursor is in the aerial win
		highlight_on_hover = false,

		-- When jumping to a symbol, highlight the line for this many ms.
		-- Set to false to disable
		highlight_on_jump = 300,

		-- Define symbol icons. You can also specify "<Symbol>Collapsed" to change the
		-- icon when the tree is collapsed at that symbol, or "Collapsed" to specify a
		-- default collapsed icon. The default icon set is determined by the
		-- "nerd_font" option below.
		-- If you have lspkind-nvim installed, it will be the default icon set.
		-- This can be a filetype map (see :help aerial-filetype-map)
		icons = {},

		-- Control which windows and buffers aerial should ignore.
		-- If attach_mode is "global", focusing an ignored window/buffer will
		-- not cause the aerial window to update.
		-- If open_automatic is true, focusing an ignored window/buffer will not
		-- cause an aerial window to open.
		-- If open_automatic is a function, ignore rules have no effect on aerial
		-- window opening behavior; it's entirely handled by the open_automatic
		-- function.
		ignore = {
			-- Ignore unlisted buffers. See :help buflisted
			unlisted_buffers = true,

			-- List of filetypes to ignore.
			filetypes = {},

			-- Ignored buftypes.
			-- Can be one of the following:
			-- false or nil - No buftypes are ignored.
			-- "special"    - All buffers other than normal buffers are ignored.
			-- table        - A list of buftypes to ignore. See :help buftype for the
			--                possible values.
			-- function     - A function that returns true if the buffer should be
			--                ignored or false if it should not be ignored.
			--                Takes two arguments, `bufnr` and `buftype`.
			buftypes = "special",

			-- Ignored wintypes.
			-- Can be one of the following:
			-- false or nil - No wintypes are ignored.
			-- "special"    - All windows other than normal windows are ignored.
			-- table        - A list of wintypes to ignore. See :help win_gettype() for the
			--                possible values.
			-- function     - A function that returns true if the window should be
			--                ignored or false if it should not be ignored.
			--                Takes two arguments, `winid` and `wintype`.
			wintypes = "special",
		},

		-- Use symbol tree for folding. Set to true or false to enable/disable
		-- Set to "auto" to manage folds if your previous foldmethod was 'manual'
		-- This can be a filetype map (see :help aerial-filetype-map)
		manage_folds = false,

		-- When you fold code with za, zo, or zc, update the aerial tree as well.
		-- Only works when manage_folds = true
		link_folds_to_tree = false,

		-- Fold code when you open/collapse symbols in the tree.
		-- Only works when manage_folds = true
		link_tree_to_folds = true,

		-- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
		-- "auto" will set it to true if nvim-web-devicons or lspkind-nvim is installed.
		nerd_font = "auto",

		-- Call this function when aerial attaches to a buffer.
		on_attach = function(bufnr)
			vim.keymap.set("n", "<C-m>", "<cmd>AerialToggle!<CR>", { buffer = bufnr })
			vim.keymap.set("n", "<C-k>", "<cmd>lua require('aerial').prev()<CR>", { buffer = bufnr })
			vim.keymap.set("n", "<C-j>", "<cmd>lua require('aerial').next()<CR>", { buffer = bufnr })
			vim.cmd([[augroup AerialClose]])
			vim.cmd([[autocmd! * <buffer>]])
			vim.cmd([[autocmd BufLeave <buffer> :AerialClose]])
			vim.cmd([[augroup END]])
		end,

		-- Call this function when aerial first sets symbols on a buffer.
		-- on_first_symbols = function(bufnr) end,

		-- Automatically open aerial when entering supported buffers.
		-- This can be a function (see :help aerial-open-automatic)
		open_automatic = false,

		-- Run this command after jumping to a symbol (false will disable)
		post_jump_cmd = "normal! zz",

		-- When true, aerial will automatically close after jumping to a symbol
		close_on_select = false,

		-- The autocmds that trigger symbols update (not used for LSP backend)
		update_events = "TextChanged,InsertLeave",

		-- Show box drawing characters for the tree hierarchy
		show_guides = false,

		-- Customize the characters used when show_guides = true
		guides = {
			-- When the child item has a sibling below it
			mid_item = "├─",
			-- When the child item is the last in the list
			last_item = "└─",
			-- When there are nested child guides to the right
			nested_top = "│ ",
			-- Raw indentation
			whitespace = "  ",
		},

		-- Options for opening aerial in a floating win
		float = {
			-- Controls border appearance. Passed to nvim_open_win
			border = "rounded",

			-- Determines location of floating window
			--   cursor - Opens float on top of the cursor
			--   editor - Opens float centered in the editor
			--   win    - Opens float centered in the window
			relative = "cursor",

			-- These control the height of the floating window.
			-- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			-- min_height and max_height can be a list of mixed types.
			-- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
			max_height = 0.9,
			height = nil,
			min_height = { 8, 0.1 },

			override = function(conf)
				-- This is the config that will be passed to nvim_open_win.
				-- Change values here to customize the layout
				return conf
			end,
		},

		lsp = {
			-- Fetch document symbols when LSP diagnostics update.
			-- If false, will update on buffer changes.
			diagnostics_trigger_update = true,

			-- Set to false to not update the symbols when there are LSP errors
			update_when_errors = true,

			-- How long to wait (in ms) after a buffer change before updating
			-- Only used when diagnostics_trigger_update = false
			update_delay = 300,
		},

		treesitter = {
			-- How long to wait (in ms) after a buffer change before updating
			update_delay = 300,
		},

		markdown = {
			-- How long to wait (in ms) after a buffer change before updating
			update_delay = 300,
		},

		man = {
			-- How long to wait (in ms) after a buffer change before updating
			update_delay = 300,
		},
	})
end

function config.cmp()
	local cmp = require("cmp")
	cmp.setup({
		sorting = {
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				require("cmp-under-comparator").under,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
		formatting = {
			format = function(entry, vim_item)
				local lspkind_icons = {
					Text = "",
					Method = "",
					Function = "",
					Constructor = "",
					Field = "",
					Variable = "",
					Class = "ﴯ",
					Interface = "",
					Module = "",
					Property = "ﰠ",
					Unit = "",
					Value = "",
					Enum = "",
					Keyword = "",
					Snippet = "",
					Color = "",
					File = "",
					Reference = "",
					Folder = "",
					EnumMember = "",
					Constant = "",
					Struct = "",
					Event = "",
					Operator = "",
					TypeParameter = "",
				}
				-- load lspkind icons
				vim_item.kind = string.format("%s %s", lspkind_icons[vim_item.kind], vim_item.kind)

				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					nvim_lua = "[LUA]",
					luasnip = "[SNIP]",
					path = "[PATH]",
					buffer = "[BUF]",
				})[entry.source.name]

				return vim_item
			end,
		},
		-- You can set mappings if you want
		--[[
        completion = {
            autocomplete = false
        },
        ]]
		mapping = cmp.mapping.preset.insert({
			["<C-l>"] = cmp.mapping.confirm({ select = true }),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<A-/>"] = cmp.mapping.complete(),
			["<A-m>"] = cmp.mapping.close(),
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<A-i>"] = cmp.mapping.scroll_docs(-4),
			["<A-n>"] = cmp.mapping.scroll_docs(4),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		-- You should specify your *installed* sources.
		sources = {
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "luasnip" },
			{ name = "path" },
			{ name = "buffer" },
		},
		experimental = {
			ghost_text = true,
		},
	})

	-- cmp.setup.cmdline(":", {
	-- 	sources = cmp.config.sources({ { name = "cmdline" } }, { { name = "path" } }),
	-- })

	-- cmp.setup.cmdline("/", {
	-- 	sources = {
	-- 		{ name = "buffer" },
	-- 	},
	-- })
end

function config.luasnip()
	require("luasnip").config.set_config({
		history = true,
		updateevents = "TextChanged,TextChangedI",
	})
	require("luasnip/loaders/from_vscode").lazy_load()
	require("luasnip/loaders/from_vscode").load({
		paths = {
			vim.fn.stdpath("config") .. "/my-snippets",
		},
	})
end

return config
