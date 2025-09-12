-- luacheck: globals vim

local main = function()
	require("core.options")
	require("core.keymaps")
	require("core.autocmd")
	require("core.python3_host_prog")
end

main()
