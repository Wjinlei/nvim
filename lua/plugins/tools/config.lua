-- luacheck: globals vim
local config = {}

function config.telescope()
	vim.cmd([[packadd sqlite.lua]])
	vim.cmd([[packadd telescope-project.nvim]])
	vim.cmd([[packadd telescope-live-grep-args.nvim]])
	vim.cmd([[packadd telescope-fzf-native.nvim]])
	vim.cmd([[packadd telescope-frecency.nvim]])
	vim.cmd([[packadd nvim-notify]])

	local actions = require("telescope.actions")
	local previewers = require("telescope.previewers")
	local Job = require("plenary.job")
	local new_maker = function(filepath, bufnr, opts)
		filepath = vim.fn.expand(filepath)
		Job:new({
			command = "file",
			args = { "--mime-type", "-b", filepath },
			on_exit = function(j)
				local mime_type = vim.split(j:result()[1], "/")[1]
				if mime_type == "text" then
					previewers.buffer_previewer_maker(filepath, bufnr, opts)
				else
					-- maybe we want to write something to the buffer here
					vim.schedule(function()
						vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
					end)
				end
			end,
		}):sync()
	end

	require("telescope").setup({
		defaults = {
			buffer_previewer_maker = new_maker,
			borderchars = { "━", "┃", "━", "┃", "┏", "┓", "┛", "┗" },
			path_display = { "absolute" },
			selection_caret = " 🐝 ",
			prompt_prefix = " 🍯 ",
			-- winblend = 10,
			results_title = false,
			preview_title = false,
			layout_config = {
				width = 0.9,
				horizontal = {
					preview_width = 0.4,
				},
			},
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
					["<A-i>"] = "preview_scrolling_up",
					["<A-n>"] = "preview_scrolling_down",
				},
				n = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
					["<A-i>"] = "preview_scrolling_up",
					["<A-n>"] = "preview_scrolling_down",
					["q"] = actions.close,
				},
			},
		},
		pickers = {
			buffers = {
				previewer = false,
			},
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
			frecency = {
				show_scores = true,
				show_unindexed = true,
				ignore_patterns = { "*.git/*", "*/tmp/*" },
			},
			project = {
				hidden_files = false, -- default: false
			},
		},
	})

	require("telescope").load_extension("fzf")
	require("telescope").load_extension("frecency")
	require("telescope").load_extension("live_grep_args")
	require("telescope").load_extension("project")
	require("telescope").load_extension("notify")
end

function config.rooter()
	require("nvim-rooter").setup({
		rooter_patterns = { ".git", ".hg", ".svn" },
		trigger_patterns = { "*" },
		manual = false,
	})
end

function config.neogit()
	require("neogit").setup({
		disable_signs = false,
		disable_hint = false,
		disable_context_highlighting = true,
		disable_commit_confirmation = true,
		-- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
		-- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
		auto_refresh = true,
		disable_builtin_notifications = false,
		use_magit_keybindings = false,
		commit_popup = {
			kind = "split",
		},
		-- Change the default way of opening neogit
		kind = "tab",
		-- customize displayed signs
		signs = {
			-- { CLOSED, OPENED }
			item = { ">", "v" },
			section = { ">", "v" },
			hunk = { "", "" },
		},
		integrations = {
			-- If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
			-- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
			--
			-- Requires you to have `sindrets/diffview.nvim` installed.
			-- use {
			--   'NeogitOrg/neogit',
			--   requires = {
			--     'nvim-lua/plenary.nvim',
			--     'sindrets/diffview.nvim'
			--   }
			-- }
			--
			diffview = false,
		},
		-- Setting any section to `false` will make the section not render at all
		sections = {
			untracked = {
				folded = false,
				hidden = false,
			},
			unstaged = {
				folded = false,
				hidden = false,
			},
			staged = {
				folded = false,
				hidden = false,
			},
			stashes = {
				folded = true,
				hidden = false,
			},
			unpulled = {
				folded = true,
				hidden = false,
			},
			unmerged = {
				folded = false,
				hidden = false,
			},
			recent = {
				folded = false,
				hidden = false,
			},
		},
		-- override/add mappings
		mappings = {
			status = {
				["q"] = "Close",
				["Q"] = "Close",
			},
			commit_editor = {
				["q"] = "Close",
				["Q"] = "Close",
			},
		},
	})
end

function config.tmux()
	require("tmux").setup({
		copy_sync = {
			-- enables copy sync and overwrites all register actions to
			-- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
			enable = false,

			-- ignore specific tmux buffers e.g. buffer0 = true to ignore the
			-- first buffer or named_buffer_name = true to ignore a named tmux
			-- buffer with name named_buffer_name :)
			ignore_buffers = { empty = false },

			-- TMUX >= 3.2: yanks (and deletes) will get redirected to system
			-- clipboard by tmux
			redirect_to_clipboard = false,

			-- offset controls where register sync starts
			-- e.g. offset 2 lets registers 0 and 1 untouched
			register_offset = 0,

			-- sync clipboard overwrites vim.g.clipboard to handle * and +
			-- registers. If you sync your system clipboard without tmux, disable
			-- this option!
			sync_clipboard = true,

			-- syncs deletes with tmux clipboard as well, it is adviced to
			-- do so. Nvim does not allow syncing registers 0 and 1 without
			-- overwriting the unnamed register. Thus, ddp would not be possible.
			sync_deletes = true,

			-- syncs the unnamed register with the first buffer entry from tmux.
			sync_unnamed = true,
		},
		navigation = {
			-- cycles to opposite pane while navigating into the border
			cycle_navigation = true,

			-- enables default keybindings (C-hjkl) for normal mode
			enable_default_keybindings = false,

			-- prevents unzoom tmux when navigating beyond vim border
			persist_zoom = false,
		},
		resize = {
			-- enables default keybindings (A-hjkl) for normal mode
			enable_default_keybindings = false,

			-- sets resize steps for x axis
			resize_step_x = 1,

			-- sets resize steps for y axis
			resize_step_y = 1,
		},
	})
end

return config
