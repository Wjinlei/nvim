-- luacheck: globals vim
local config = {}

function config.lspconfig()
	require("plugins.completion.lspconfig")
end

function config.lightbulb()
	vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
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
