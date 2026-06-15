-- loading lsp files dynamically from lsp/* and enabling them

local configs = vim.lsp.get_configs()
local names = vim.tbl_map(function(config)
	return config.name
end, configs)

vim.lsp.enable(names)

--vim.lsp.enable({
--	"lua_ls",
--	"gopls",
--	"cssls",
--	"svelte",
--	"tailwindcss",
--	"ts_ls",
--})
