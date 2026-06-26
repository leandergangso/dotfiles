local lsp_files = vim.api.nvim_get_runtime_file("lsp/*.lua", true)
local names = {}

for _, filepath in ipairs(lsp_files) do
	-- Extract the file name without the path and without `.lua` (e.g., "lsp/gopls.lua" -> "gopls")
	local name = vim.fs.basename(filepath):gsub("%.lua$", "")
	table.insert(names, name)
end

if #names > 0 then
	vim.lsp.enable(names)
end
