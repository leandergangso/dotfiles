local files = vim.api.nvim_get_runtime_file("lua/lsp/*.lua", true)

for i = 1, #files do
	local file = files[i]

	local name = file:match("lua/lsp/(.+)%.lua$")
	if name then
		local ok, cfg = pcall(require, "lsp." .. name)
		if ok and type(cfg) == "table" then
			vim.lsp.config(name, cfg)
			vim.lsp.enable(name)
		else
			vim.vim.notify(("invalid LSP config: %s"):format(name), vim.log.levels.WARN)
		end
	end
end
