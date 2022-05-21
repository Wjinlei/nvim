-- luacheck: globals vim
vim.cmd([[packadd lsp_signature.nvim]])
vim.cmd([[packadd aerial.nvim]])
vim.cmd([[packadd nvim-lsp-installer]])
vim.cmd([[packadd cmp-nvim-lsp]])
vim.cmd([[packadd lspsaga.nvim]])
vim.cmd([[packadd efmls-configs-nvim]])
require("nvim-lsp-installer").setup({})
local lspconfig = require("lspconfig")
local saga = require("lspsaga")

-- require nvim 0.8
local filter_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(clients)
			-- filter out clients that you don't want to use
			return vim.tbl_filter(function(client)
				return client.name ~= "tsserver"
					and client.name ~= "volar"
					and client.name ~= "html"
					and client.name ~= "clangd"
			end, clients)
		end,
		bufnr = bufnr,
	})
end

-- Open Lsp server info
vim.api.nvim_set_keymap("n", "<LEADER>lsp", ":LspInstallInfo<CR>", {})

local function keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "rn", ":Lspsaga rename<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "rf", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

	vim.keymap.set("n", "<LEADER>f", function()
		filter_formatting(bufnr)
	end, { buffer = bufnr })
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<A-a>", ":Lspsaga code_action<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "v", "<A-a>", ":<C-U>Lspsaga range_code_action<CR>", opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<A-i>",
		'<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
		opts
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<A-n>",
		'<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
		opts
	)
end

local on_attach = function(client, bufnr)
	keymaps(bufnr)

	require("aerial").on_attach(client, {
		vim.api.nvim_buf_set_keymap(bufnr, "n", "mm", "<cmd>AerialToggle!<CR>", {}),
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>AerialPrevUp<CR>", {}),
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-j>", "<cmd>AerialNextUp<CR>", {}),
	})
	vim.cmd([[augroup AerialClose]])
	vim.cmd([[autocmd! * <buffer>]])
	vim.cmd([[autocmd BufLeave <buffer> :AerialClose]])
	vim.cmd([[augroup END]])

	require("lsp_signature").on_attach({
		hi_parameter = "Search",
		bind = true,
		hint_enable = true,
		hint_prefix = "🐼 ",
		use_lspsaga = false,
		floating_window = false,
		fix_pos = true,
	})

	-- Add BufWritePost event with save format
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePost", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				filter_formatting(bufnr)
			end,
		})
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local servers = { "clangd", "volar", "tsserver", "gopls", "sumneko_lua", "html", "cssls" }
for _, server in ipairs(servers) do
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = { debounce_text_changes = 500 },
	}

	if server == "clangd" then
		local clangd_opts = require("plugins.completion.settings.clangd")
		opts = vim.tbl_deep_extend("force", clangd_opts, opts)
		opts.capabilities.offsetEncoding = { "utf-16" }
	end
	lspconfig[server].setup(opts)
end

local efmls = require("efmls-configs")

-- Init `efm-langserver` here.

efmls.init({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = { documentFormatting = true, codeAction = true },
})

local eslint = require("efmls-configs.linters.eslint")
local clangtidy = require("efmls-configs.linters.clang_tidy")
local luacheck = require("efmls-configs.linters.luacheck")

local prettier = require("efmls-configs.formatters.prettier")
local clangformat = require("efmls-configs.formatters.clang_format")
local stylua = require("efmls-configs.formatters.stylua")

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
	html = { formatter = prettier },
	css = { formatter = prettier },
	less = { formatter = prettier },
	vue = { formatter = prettier, linter = eslint },
	typescript = { formatter = prettier, linter = eslint },
	javascript = { formatter = prettier, linter = eslint },
	c = { formatter = clangformat, linter = clangtidy },
	cpp = { formatter = clangformat, linter = clangtidy },
	lua = { formatter = stylua, linter = luacheck },
})

-- Override diagnostics symbol
saga.init_lsp_saga({
	debug = false,
	code_action_icon = "💡",
	diagnostic_header_icon = "🐞",
	code_action_prompt = {
		virtual_text = false,
	},
	use_saga_diagnostic_sign = true,
	infor_sign = "",
	warn_sign = "",
	error_sign = "",
	hint_sign = "",
	rename_prompt_prefix = "📝",
})
