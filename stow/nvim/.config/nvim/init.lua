local start_time = vim.loop.hrtime()

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local loaded = 0
		local pack = require("pack")
		local plugins = vim.pack.get()

		for _, plugin in ipairs(plugins) do
			local state = pack.state(plugin)
			if state == "loaded" then
				loaded = loaded + 1
			end
		end

		vim.g.pack_startup_summary =
			string.format("loaded %d/%d plugins in %.1f ms", loaded, #plugins, (vim.loop.hrtime() - start_time) / 1e6)
	end,
})

require("options")
require("keymaps")
require("filetypes")
require("events")
require("lsp")
