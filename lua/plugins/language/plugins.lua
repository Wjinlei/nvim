-- luacheck: globals vim
local language = {}
local keymap = vim.api.nvim_set_keymap

language["iamcco/markdown-preview.nvim"] = {
	run = function()
		vim.fn["mkdp#util#install"]()
	end,
	keymap("n", "<C-c>m", "<Plug>MarkdownPreviewToggle", { noremap = true, silent = true }),
}

-- 在 Neovim 中提升你的 Rust 体验！Rust-tools.nvim 的复刻版本
-- https://github.com/mrcjkb/rustaceanvim  
-- 此插件无须设置，不依赖lspconfig
-- 请勿手动调用nvim-lspconfig.rust_analyzer 设置或设置 LSP 客户端rust-analyzer，因为这样做可能会导致冲突。
-- 需要安装 rust_analyzer，可使用<LEADER>lsp 安装
language["mrcjkb/rustaceanvim"] = {}

return language
