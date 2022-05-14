local completion = {}
local conf = require("plugins.completion.config")

completion["hrsh7th/nvim-cmp"] = {
	config = conf.cmp,
	requires = {
		{ "lukas-reineke/cmp-under-comparator" },
		{ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
		{ "hrsh7th/cmp-nvim-lsp", after = "cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer", after = "cmp-nvim-lua" },
		{ "hrsh7th/cmp-path", after = "cmp-cmdline" },
		{ "hrsh7th/cmp-cmdline", after = "cmp-buffer" },
	},
}
completion["L3MON4D3/LuaSnip"] = {
	after = "nvim-cmp",
	config = conf.luasnip,
	requires = { "rafamadriz/friendly-snippets" },
}
completion["windwp/nvim-autopairs"] = { after = "nvim-cmp", config = conf.autopairs }
completion["neovim/nvim-lspconfig"] = { config = conf.lspconfig }
completion["williamboman/nvim-lsp-installer"] = { after = "nvim-lspconfig" }
completion["tami5/lspsaga.nvim"] = { after = "nvim-lspconfig" }
completion["ray-x/lsp_signature.nvim"] = { after = "nvim-lspconfig" }
completion["kosayoda/nvim-lightbulb"] = { after = "nvim-lspconfig", config = conf.lightbulb }
completion["stevearc/aerial.nvim"] = { after = "nvim-lspconfig", config = conf.aerial }
completion["creativenull/efmls-configs-nvim"] = { requires = { "neovim/nvim-lspconfig" } }

return completion
