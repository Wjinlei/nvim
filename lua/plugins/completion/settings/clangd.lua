return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--cross-file-rename=true",
		"--header-insertion=iwyu",
		"--pch-storage=memory",
		"--function-arg-placeholders=false",
		"--ranking-model=decision_forest",
		"--header-insertion-decorators",
		"--offset-encoding=utf-16",
		"--pretty",
		"-j=12",
	},
}
