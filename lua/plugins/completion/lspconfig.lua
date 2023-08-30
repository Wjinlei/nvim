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
	automatic_installation = true,
	handlers = nil,
})

-- Lspconfig
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({})
lspconfig.bashls.setup({})
lspconfig.jsonls.setup({})
lspconfig.clangd.setup(require("plugins.completion.server_config.clangd"))
lspconfig.gopls.setup({})
lspconfig.jdtls.setup(require("plugins.completion.server_config.jdtls"))
lspconfig.volar.setup(require("plugins.completion.server_config.volar"))
lspconfig.tsserver.setup({})
lspconfig.html.setup({})
lspconfig.cssls.setup({})
lspconfig.eslint.setup({})
lspconfig.pyright.setup({})
lspconfig.rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {},
	},
})

-- Global mappings.
vim.keymap.set("n", "<C-cr>", "<cmd>Lspsaga term_toggle<cr>", keymap_opts)
vim.keymap.set("i", "<C-cr>", "<cmd>Lspsaga term_toggle<cr>", keymap_opts)
vim.keymap.set("n", "<A-cr>", "<cmd>Lspsaga outline<cr>", keymap_opts)

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
		vim.keymap.set("n", "<A-a>", "<cmd>Lspsaga code_action<cr>", opts)
		vim.keymap.set("v", "<A-a>", "<cmd>Lspsaga code_action<cr>", opts)
		vim.keymap.set("n", "<LEADER>rn", "<cmd>Lspsaga rename<cr>", opts)
		vim.keymap.set("n", "<LEADER>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

local languages = require("efmls-configs.defaults").languages()
languages = vim.tbl_extend("force", languages, {
	-- Custom languages, or override existing ones
	sh = {
		require("efmls-configs.linters.shellcheck"),
		require("efmls-configs.formatters.shfmt"),
	},
	cpp = {
		require("efmls-configs.linters.clang_tidy"),
		require("efmls-configs.formatters.clang_format"),
	},
	c = {
		require("efmls-configs.linters.clang_tidy"),
		require("efmls-configs.formatters.clang_format"),
	},
	rust = {
		require("efmls-configs.formatters.rustfmt"),
	},
	json = {
		require("efmls-configs.formatters.prettier"),
	},
	jsonc = {
		require("efmls-configs.formatters.prettier"),
	},
})

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

lspconfig.efm.setup(vim.tbl_extend("force", efmls_config, {
	-- Pass your custom lsp config below like on_attach and capabilities
	--
	-- on_attach = on_attach,
	-- capabilities = capabilities,
}))
