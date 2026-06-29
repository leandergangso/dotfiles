vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "gofmt" },
		python = { "black", "isort" },
		svelte = { "prettier" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		json = { "prettier" },
		markdown = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		nix = { "nixfmt" },
	},
})

-- format on save
--vim.api.nvim_create_autocmd("BufWritePre", {
--    pattern = "*",
--    callback = function(args)
--        require("conform").format({ bufnr = args.buf, lsp_format = "fallback", timeout_ms = 500 })
--    end,
--})

-- format current buffer
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ async = true, lsp_format = "fallback", timeout_ms = 500 })
end, { desc = "[F]ormat buffer" })

-- format all buffers
vim.keymap.set("n", "<leader>fa", function()
	local buffers = vim.api.nvim_list_bufs()

	for _, bufnr in ipairs(buffers) do
		-- Only format loaded, editable files (ignores things like NvimTree or terminal buffers)
		if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].modifiable then
			require("conform").format({
				async = true,
				bufnr = bufnr,
				lsp_format = "fallback",
				timeout_ms = 500,
			})
		end
	end
	print("Formatted all active buffers!")
end, { desc = "[F]ormat [A]ll open buffers" })
