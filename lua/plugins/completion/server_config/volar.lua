local global = require("core.global")

local config = {
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
	init_options = {
		typescript = {
			tsdk = global.mason_dir .. "/packages/vue-language-server/node_modules/typescript/lib",
		},
	},
}
return config
