-- luacheck: globals vim
local keymap_opts = { noremap = true, silent = true }
vim.cmd([[packadd cmp-nvim-lsp]])
vim.cmd([[packadd efmls-configs-nvim]])
vim.cmd([[packadd mason.nvim]])
vim.cmd([[packadd mason-lspconfig.nvim]])

-- Mason
require("mason").setup()
vim.api.nvim_set_keymap("n", "<LEADER>lsp", ":Mason<CR>", {})
vim.api.nvim_set_keymap("n", "<LEADER>lsi", ":LspInfo<CR>", {})

require("mason-lspconfig").setup({
	automatic_enable = {
		"efm",
		"html",
		"cssls",
		"tailwindcss",
		"clangd",
		"rust_analyzer",
		"gopls",
		"pyright",
		-- "phpactor",
		-- "psalm",
		"vue_ls",
		"vtsls",
		"lua_ls",
		"jsonls",
		"bashls",
	},
	ensure_installed = {
		"efm",
		"html",
		"cssls",
		"tailwindcss",
		"clangd",
		"rust_analyzer",
		"gopls",
		"pyright",
		-- "phpactor",
		-- "psalm", -- 这个需要安装php包管理器composer才能通过Mason安装
		"vue_ls",
		"vtsls",
		"lua_ls",
		"jsonls",
		"bashls",
	}
})

-- vtsls
local vue_language_server_path = vim.fn.stdpath('data') ..
	"/mason/packages/vue-language-server/node_modules/@vue/language-server"
local vue_plugin = {
	name = '@vue/typescript-plugin',
	location = vue_language_server_path,
	languages = { 'vue' },
	configNamespace = 'typescript',
}
vim.lsp.config('vtsls', {
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin,
				},
			},
		},
	},
	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})

-- lua_ls
vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			format = {
				enable = true,
				defaultConfig = {
					-- 下面设置没用，因为编辑器的缩进设置覆盖了它
					indent_style = "space",
					indent_size = "2",
				}
			}
		}
	}
})

-- Global mappings.
vim.keymap.set("n", "<C-\\>", "<cmd>Lspsaga term_toggle<cr>", keymap_opts)
vim.keymap.set("i", "<C-\\>", "<cmd>Lspsaga term_toggle<cr>", keymap_opts)
vim.keymap.set("n", "<C-o>", "<cmd>Lspsaga outline<cr>", keymap_opts)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gH", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<LEADER>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<LEADER>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<LEADER>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga show_buf_diagnostics<cr>", opts)
		vim.keymap.set("n", "<A-i>", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
		vim.keymap.set("n", "<A-n>", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
		vim.keymap.set("n", "<A-c>", "<cmd>Lspsaga code_action<cr>", opts)
		vim.keymap.set("v", "<A-c>", "<cmd>Lspsaga code_action<cr>", opts)
		vim.keymap.set("n", "<LEADER>rn", "<cmd>Lspsaga rename<cr>", opts)
		vim.keymap.set("n", "<LEADER>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

-- shell
local shellcheck = require("efmls-configs.linters.shellcheck")
local shfmt = require("efmls-configs.formatters.shfmt")

local languages = {
	sh = { shellcheck, shfmt },
}

local efmls_config = {
	filetypes = vim.tbl_keys(languages),
	settings = {
		rootMarkers = { ".git/" },
		languages = languages,
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
	},
}

-- If using nvim >= 0.11 then use the following
vim.lsp.config('efm', vim.tbl_extend('force', efmls_config, {
	cmd = { 'efm-langserver' },
	-- Pass your custom lsp config below like on_attach and capabilities
	--
	-- on_attach = on_attach,
	-- capabilities = capabilities,
}))
