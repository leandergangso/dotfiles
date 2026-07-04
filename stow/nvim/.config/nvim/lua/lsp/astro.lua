-- NOTE: not working

---@type vim.lsp.Config
return {
	name = "astro-ls",
	cmd = { "astro-ls", "--stdio" },
	root_dir = vim.fs.dirname(vim.fs.find({ "package.json", ".git" }, { upward = true })[1]),
	init_options = {
		typescript = {
			-- Use a shell command to find the real path automatically
			tsdk = vim.fn.trim(
				vim.fn.system("find " .. vim.fn.getcwd() .. " -name tsserverlibrary.js -print -quit | xargs dirname")
			),
		},
	},
}
