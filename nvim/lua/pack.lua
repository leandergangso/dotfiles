local M = {}

local function open_report(lines)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].swapfile = false
	vim.bo[buf].modifiable = true
	vim.bo[buf].filetype = "checkhealth"
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false

	vim.cmd("botright new")
	vim.api.nvim_win_set_buf(0, buf)

	vim.keymap.set("n", "q", "<cmd>bd!<CR>", { buffer = buf, silent = true, nowait = true })
end

function M.list()
	local plugins = vim.pack.get()
	local fmt = "%-8s  %-28s  %-10s  %s"
	local active = 0

	table.sort(plugins, function(a, b)
		if a.active ~= b.active then
			return a.active and not b.active
		end

		return a.spec.name < b.spec.name
	end)

	local lines = {
		"vim.pack",
		"",
		"Summary",
		string.format("  loaded: %d", 0),
		string.format("  inactive: %d", #plugins),
		string.format("  total: %d", #plugins),
		"",
		"Plugins",
		fmt:format("Active", "Name", "Rev", "Path"),
	}

	for _, plugin in ipairs(plugins) do
		if plugin.active then
			active = active + 1
		end
		lines[#lines + 1] = fmt:format(
			plugin.active and "yes" or "no",
			plugin.spec.name,
			plugin.rev:sub(1, 8),
			plugin.path
		)
	end

	lines[4] = string.format("  loaded: %d", active)
	lines[5] = string.format("  inactive: %d", #plugins - active)

	open_report(lines)
end

function M.prune()
	local plugins = vim.pack.get()
	local names = {}

	for _, plugin in ipairs(plugins) do
		if not plugin.active then
			names[#names + 1] = plugin.spec.name
		end
	end

	if #names == 0 then
		vim.notify("No inactive plugins to delete.", vim.log.levels.INFO)
		return
	end

	local choice = vim.fn.confirm(
		string.format("Delete %d inactive plugins?", #names),
		"&Delete\n&Cancel",
		2
	)

	if choice ~= 1 then
		return
	end

	vim.pack.del(names)
	vim.notify(string.format("Deleted %d inactive plugins.", #names), vim.log.levels.INFO)
end

return M
