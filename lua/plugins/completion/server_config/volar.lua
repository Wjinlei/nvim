local global = require("core.global")

local config = {
	init_options = {
		typescript = {
			tsdk = global.mason_dir .. "/packages/vue-language-server/node_modules/typescript/lib",
		},
	},
}
return config
