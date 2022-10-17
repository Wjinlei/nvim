-- luacheck: globals vim
local tsdk = string.format("%s/lsp_servers/volar/node_modules/typescript/lib", vim.fn.stdpath("data"))

return {
	init_options = {
		typescript = {
			tsdk = tsdk,
		},
	},
}
