local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local my_group = augroup("MyGroup", {})
local yank_group = augroup("YankGroup", {})

-- highlight yanked text for a brief moment
autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 80,
		})
	end,
})

autocmd("FileType", {
	group = my_group,
	pattern = "go",
	callback = function(args)
		local opts = { buffer = args.buf }

		vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", opts)
		vim.keymap.set("n", "<leader>ep", "oif err != nil {<CR>}<Esc>Opanic(err)<Esc>", opts)
		vim.keymap.set("n", "<leader>ea", 'oassert.NoError(err, "")<Esc>F";a', opts)
		vim.keymap.set(
			"n",
			"<leader>ef",
			'oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\\n", err.Error())<Esc>jj',
			opts
		)
		vim.keymap.set(
			"n",
			"<leader>el",
			'oif err != nil {<CR>}<Esc>O.logger.Error("error", "error", err)<Esc>F.;i',
			opts
		)
	end,
})

-- setup LSP keymaps
autocmd("LspAttach", {
	group = my_group,
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
	end,
})

--autocmd("CursorHoldI", {
--	group = MyGroup,
--	callback = function()
--		vim.lsp.buf.signature_help()
--	end,
--})
