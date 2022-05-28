return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--pch-storage=memory",
		"--header-insertion=iwyu",
		"--header-insertion-decorators",
		"--offset-encoding=utf-16",
		"--pretty",
		"-j=12",
	},
}
