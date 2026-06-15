local start_time = vim.loop.hrtime()

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local loaded = 0

		for _, plugin in ipairs(vim.pack.get()) do
			if plugin.active then
				loaded = loaded + 1
			end
		end

		vim.g.pack_startup_summary =
			string.format("loaded %d plugins in %.1f ms", loaded, (vim.loop.hrtime() - start_time) / 1e6)
	end,
})

require("options")
require("keymaps")
require("filetypes")
require("events")
