return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},
	config = function()
		local cmp_lsp = require("cmp_nvim_lsp")

		local capabilities =
			vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

		require("fidget").setup({})
		require("mason").setup({})

		local function configure_lsp(server_name, config)
			config = config or {}
			config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})

			vim.lsp.config(server_name, config)
		end

		configure_lsp("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})

		configure_lsp("gopls", {
			settings = {
				gopls = {
					gofumpt = true,
					staticcheck = true,
					usePlaceholders = true,
					completeUnimported = true,
					analyses = {
						unusedparams = true,
						unusedwrite = true,
						nilness = true,
						shadow = false,
						ST1000 = false, -- hide warning: at least one package should have comment
					},
				},
			},
		})

		configure_lsp("cssls", {
			settings = {
				css = {
					lint = {
						unknownAtRules = "ignore",
					},
				},
				scss = {
					lint = {
						unknownAtRules = "ignore",
					},
				},
				less = {
					lint = {
						unknownAtRules = "ignore",
					},
				},
			},
		})

		configure_lsp("svelte", {})
		configure_lsp("tailwindcss", {})
		configure_lsp("ts_ls", {})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"gopls",
				"cssls",
				"svelte",
				"tailwindcss",
				"ts_ls",
			},
			automatic_enable = true,
		})

		vim.api.nvim_set_hl(0, "CmpItemAbbr", { link = "Comment" })
		vim.api.nvim_set_hl(0, "CmpItemMenu", { link = "Comment" })

		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			preselect = cmp.PreselectMode.None,

			completion = {
				completeopt = "menu,menuone,noinsert",
			},

			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},

			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
				{ name = "path" },
			}),

			window = {
				completion = cmp.config.window.bordered({
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
				}),
				documentation = cmp.config.window.bordered({
					border = { "", "", "", " " },
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
				}),
			},

			formatting = {
				fields = { "abbr", "kind", "menu" },
				format = function(entry, vim_item)
					vim_item.kind = " " .. vim_item.kind
					vim_item.menu = ({
						nvim_lsp = "LSP",
						luasnip = "Snip",
						buffer = "Buf",
						path = "Path",
					})[entry.source.name] or ""

					return vim_item
				end,
			},
		})
	end,
}
