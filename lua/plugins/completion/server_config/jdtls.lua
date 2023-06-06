-- luacheck: globals vim
vim.cmd([[packadd nvim-jdtls]])

local global = require("core.global")
local root_markers = { "gradlew", "mvnw", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)

local config = {
	cmd = {
		"/usr/local/jdk-17.0.7/bin/java", -- or '/path/to/java17_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- If you use lombok, download the lombok jar and place it in ~/.local/share/eclipse
		"-javaagent:"
			.. global.mason_dir
			.. "/packages/jdtls/lombok.jar",

		-- The jar file is located where jdtls was installed. This will need to be updated
		-- to the location where you installed jdtls
		"-jar",
		vim.fn.glob(global.mason_dir .. "/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),

		-- The configuration for jdtls is also placed where jdtls was installed. This will
		-- need to be updated depending on your environment
		"-configuration",
		global.mason_dir .. "/packages/jdtls/config_linux",

		-- Use the workspace_folder defined above to store data for this project
		"-data",
		global.home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t"),
	},
}

return config
