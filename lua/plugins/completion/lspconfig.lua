-- luacheck: globals vim
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
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<A-i>", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<A-n>", vim.diagnostic.goto_next)

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
		vim.keymap.set("n", "<LEADER>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<A-a>", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<LEADER>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

-- Efmls-configs
local efmls = require("efmls-configs")

efmls.init({
	-- Enable formatting provided by efm langserver
	init_options = {
		documentFormatting = true,
	},
})

-- Linters
local eslint = require("efmls-configs.linters.eslint")
local shellcheck = require("efmls-configs.linters.shellcheck")
local luacheck = require("efmls-configs.linters.luacheck")
local clangtidy = require("efmls-configs.linters.clang_tidy")

-- Formatters
local prettier = require("efmls-configs.formatters.prettier")
local stylua = require("efmls-configs.formatters.stylua")
local shfmt = require("efmls-configs.formatters.shfmt")
local clangformat = require("efmls-configs.formatters.clang_format")

clangformat = vim.tbl_extend("force", clangformat, {
	prefix = "clangfmt",
	formatCommand = 'clang-format --style="{BasedOnStyle: WebKit, IndentWidth: 8}" ${INPUT}',
	formatStdin = true,
})

prettier = vim.tbl_extend("force", prettier, {
	prefix = "prettier",
	formatCommand = "prettier --arrow-parens=avoid --stdin --stdin-filepath ${INPUT}",
	formatStdin = true,
})

efmls.setup({
	--------- Back-end development ---------
	c = { formatter = clangformat, linter = clangtidy },
	cpp = { formatter = clangformat, linter = clangtidy },
	sh = { formatter = shfmt, linter = shellcheck },
	lua = { formatter = stylua, linter = luacheck },

	------- Web front-end development -------
	html = { formatter = prettier },
	less = { formatter = prettier },
	sass = { formatter = prettier },
	css = { formatter = prettier },
	javascript = { formatter = prettier, linter = eslint },
	typescript = { formatter = prettier, linter = eslint },
	vue = { formatter = prettier, linter = eslint },
})
