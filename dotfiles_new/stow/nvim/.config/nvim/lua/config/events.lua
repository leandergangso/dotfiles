local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local MyGroup = augroup("MyGroup", {})
local YankGroup = augroup("YankGroup", {})

-- highlight yanked text for a brief moment
autocmd("TextYankPost", {
	group = YankGroup,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 80,
		})
	end,
})

-- setup LSP keymaps
autocmd("LspAttach", {
	group = MyGroup,
	callback = function(e)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, { buffer = e.buf, desc = "[K] Hover" })
		vim.keymap.set("n", "<leader>e", function()
			vim.diagnostic.open_float({
				scope = "cursor",
				focusable = false,
			})
		end, { buffer = e.buf, desc = "[E] Diagnostic" })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = e.buf, desc = "[G]oto [D]efinition" })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = e.buf, desc = "[G]oto [R]eferences" })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = e.buf, desc = "[C]ode [A]ction" })
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = e.buf, desc = "[R]e[N]ame" })
		vim.keymap.set(
			"n",
			"<leader>ws",
			vim.lsp.buf.workspace_symbol,
			{ buffer = e.buf, desc = "[W]orkspace [S]ymbol" }
		)
		--vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { buffer = e.buf, desc = "[F]ormat buffer" })
		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({
				async = true,
				lsp_format = "fallback",
			})
		end, { buffer = e.buf, desc = "[F]ormat buffer" })
	end,
})

--autocmd("CursorHoldI", {
--	group = MyGroup,
--	callback = function()
--		vim.lsp.buf.signature_help()
--	end,
--})
