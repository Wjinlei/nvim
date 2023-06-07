local global = require("core.global")

local config = {
	init_options = {
		typescript = {
			tsdk = string.format("%s/packages/vue-language-server/node_modules/typescript/lib", global.mason_dir),
		},
	},
}
return config
