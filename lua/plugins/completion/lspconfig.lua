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
        "vue_ls",
        "vtsls",
        "gopls",
    }
})

-- vtsls
local vue_language_server_path = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
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
		vim.keymap.set("n", "<A-a>", "<cmd>Lspsaga code_action<cr>", opts)
		vim.keymap.set("v", "<A-a>", "<cmd>Lspsaga code_action<cr>", opts)
		vim.keymap.set("n", "<LEADER>rn", "<cmd>Lspsaga rename<cr>", opts)
		vim.keymap.set("n", "<LEADER>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

-- front-end
local stylelint = require("efmls-configs.linters.stylelint")
local eslint = require("efmls-configs.linters.eslint")
local prettier_eslint = require("efmls-configs.formatters.prettier_eslint")

-- shell
local shellcheck = require("efmls-configs.linters.shellcheck")
local shfmt = require("efmls-configs.formatters.shfmt")

-- golang
local golangci_lint = require("efmls-configs.linters.golangci_lint")
local gofmt = require("efmls-configs.formatters.gofmt")

-- python
local autopep8 = require("efmls-configs.formatters.autopep8")
local flake8 = require("efmls-configs.linters.flake8")

local languages = {
	-- Custom languages, or override existing ones
	javascript = { eslint, prettier_eslint },
	javascriptreact = { eslint, prettier_eslint },
	typescript = { eslint, prettier_eslint },
	typescriptreact = { eslint, prettier_eslint },
	less = { stylelint, prettier_eslint },
	scss = { stylelint, prettier_eslint },
	sass = { stylelint, prettier_eslint },
	html = { prettier_eslint },
	json = { prettier_eslint },
	css = { stylelint, prettier_eslint },
	vue = { eslint, prettier_eslint },

	python = { flake8, autopep8 },
	lua = { luacheck, stylua },
	go = { golangci_lint, gofmt },
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
