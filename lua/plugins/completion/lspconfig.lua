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
lspconfig.gopls.setup({})
lspconfig.clangd.setup(require("plugins.completion.server_config.clangd"))
lspconfig.jdtls.setup(require("plugins.completion.server_config.jdtls"))
lspconfig.volar.setup(require("plugins.completion.server_config.volar"))
lspconfig.intelephense.setup({})
lspconfig.tsserver.setup({})
lspconfig.html.setup({})
lspconfig.cssls.setup({})
-- lspconfig.jsonls.setup({})
-- lspconfig.eslint.setup({})
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

local eslint = require("efmls-configs.linters.eslint")
local stylelint = require("efmls-configs.linters.stylelint")
-- local prettier = require("efmls-configs.formatters.prettier")
local prettier_eslint = require("efmls-configs.formatters.prettier_eslint")
local shellcheck = require("efmls-configs.linters.shellcheck")
local shfmt = require("efmls-configs.formatters.shfmt")
local clang_tidy = require("efmls-configs.linters.clang_tidy")
local clang_format = require("efmls-configs.formatters.clang_format")
local rustfmt = require("efmls-configs.formatters.rustfmt")
local luacheck = require("efmls-configs.linters.luacheck")
local stylua = require("efmls-configs.formatters.stylua")
local golangci_lint = require("efmls-configs.linters.golangci_lint")
local gofmt = require("efmls-configs.formatters.gofmt")
local flake8 = require("efmls-configs.linters.flake8")
local autopep8 = require("efmls-configs.formatters.autopep8")
local vint = require("efmls-configs.linters.vint")
local phpcs = require("efmls-configs.linters.phpcs")
local phpcbf = require("efmls-configs.formatters.phpcbf")

local languages = {
	-- Custom languages, or override existing ones
	vim = { vint },
	html = { prettier_eslint },
	css = { stylelint, prettier_eslint },
	less = { stylelint, prettier_eslint },
	scss = { stylelint, prettier_eslint },
	sass = { stylelint, prettier_eslint },
	javascript = { eslint, prettier_eslint },
	javascriptreact = { eslint, prettier_eslint },
	typescript = { eslint, prettier_eslint },
	typescriptreact = { eslint, prettier_eslint },
	vue = { eslint, prettier_eslint },
	c = { clang_tidy, clang_format },
	cpp = { clang_tidy, clang_format },
	lua = { luacheck, stylua },
	php = { phpcs, phpcbf },
	go = { golangci_lint, gofmt },
	rust = { rustfmt },
	python = { flake8, autopep8 },
	sh = { shellcheck, shfmt },
	json = { prettier_eslint },
	jsonc = { prettier_eslint },
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

lspconfig.efm.setup(vim.tbl_extend("force", efmls_config, {
	-- Pass your custom lsp config below like on_attach and capabilities
	--
	-- on_attach = on_attach,
	-- capabilities = capabilities,
}))
