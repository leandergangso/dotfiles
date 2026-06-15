vim.pack.add({
	{
		src = "https://github.com/Saghen/blink.cmp",
		version = vim.version.range("1"),
	},
}, {
	load = function(plugin)
		vim.api.nvim_create_autocmd("InsertEnter", {
			once = true,
			callback = function()
				vim.cmd.packadd(plugin.spec.name)
				require("blink.cmp").setup({
					keymap = {
						preset = "default",
					},
					appearance = {
						nerd_font_variant = "mono",
					},
					completion = {
						documentation = {
							auto_show = false,
						},
					},
					sources = {
						default = { "lsp", "path", "snippets", "buffer" },
					},
					snippets = {
						preset = "default",
					},
					fuzzy = {
						implementation = "prefer_rust_with_warning",
					},
				})
			end,
		})
	end,
})
