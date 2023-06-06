-- luacheck: globals vim
vim.cmd([[packadd cmp-nvim-lsp]])
vim.cmd([[packadd lspsaga.nvim]])
vim.cmd([[packadd efmls-configs-nvim]])
vim.cmd([[packadd mason.nvim]])
require("mason").setup()

local saga = require("lspsaga")
local lspconfig = require("lspconfig")

-- Override diagnostics symbol
saga.init_lsp_saga({
	debug = false,
	code_action_icon = "💡",
	diagnostic_header_icon = "🐞",
	code_action_prompt = { virtual_text = false },
	use_saga_diagnostic_sign = true,
	hint_sign = "🌠",
	infor_sign = "✨",
	warn_sign = "🔥",
	error_sign = "💥",
	rename_prompt_prefix = "📝",
})

-- Open Mason
vim.api.nvim_set_keymap("n", "<LEADER>lsp", ":Mason<CR>", {})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local servers = {
	"bashls",
	"clangd",
	"gopls",
	"rust_analyzer",
	-- "omnisharp",
	"lua_ls",
	"volar",
	"tsserver",
	"html",
	"cssls",
}

for _, server in ipairs(servers) do
	local opts = {
		on_attach = require("plugins.completion.on_attach").on_attach,
		capabilities = capabilities,
		flags = { debounce_text_changes = 150 },
	}

	-- Bug: https://github.com/OmniSharp/omnisharp-roslyn/issues/2484
	-- if server == "omnisharp" then
	-- 	local omnisharp_opts = require("plugins.completion.settings.omnisharp")
	-- 	opts = vim.tbl_deep_extend("force", omnisharp_opts, opts)
	-- end

	if server == "clangd" then
		local clangd_opts = require("plugins.completion.settings.clangd")
		opts = vim.tbl_deep_extend("force", clangd_opts, opts)
		opts.capabilities.offsetEncoding = { "utf-16" }
	end

	if server == "volar" then
		local volar_opts = require("plugins.completion.settings.volar")
		opts = vim.tbl_deep_extend("force", volar_opts, opts)
	end

	lspconfig[server].setup(opts)
end

local efmls = require("efmls-configs")

-- Init `efm-langserver` here.

efmls.init({
	on_attach = require("plugins.completion.on_attach").on_attach,
	capabilities = capabilities,
	init_options = { documentFormatting = true, codeAction = true },
})

----- linters ------
local eslint = require("efmls-configs.linters.eslint")
local shellcheck = require("efmls-configs.linters.shellcheck")
local luacheck = require("efmls-configs.linters.luacheck")
-- local clangtidy = require("efmls-configs.linters.clang_tidy")

---- formatters ----
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
	formatCommand = "prettier --arrow-parens=avoid --trailing-comma=none --stdin --stdin-filepath ${INPUT}",
	formatStdin = true,
})

efmls.setup({
	--------- Back-end development ---------
	sh = { formatter = shfmt, linter = shellcheck },
	lua = { formatter = stylua, linter = luacheck },
	c = { formatter = clangformat },
	cpp = { formatter = clangformat },

	------- Web front-end development -------
	vue = { formatter = prettier, linter = eslint },
	javascript = { formatter = prettier, linter = eslint },
	typescript = { formatter = prettier, linter = eslint },
	html = { formatter = prettier },
	css = { formatter = prettier },
	less = { formatter = prettier },
	sass = { formatter = prettier },
})
