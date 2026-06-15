return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "gofmt" },

			-- Format these with Prettier.
			svelte = { "prettier" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			json = { "prettier" },
			markdown = { "prettier" },

			-- Intentionally do not format Tailwind CSS entry files.
			css = { "prettier" },
			scss = { "prettier" },
		},

		--format_on_save = function(bufnr)
		--	local ft = vim.bo[bufnr].filetype
		--	if ft == "css" or ft == "scss" then
		--		return nil
		--	end
		--	return {
		--		timeout_ms = 1000,
		--		lsp_format = "fallback",
		--	}
		--end,
	},
}
