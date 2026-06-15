vim.g.netrw_browse_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"
vim.opt.signcolumn = "yes"
vim.opt.inccommand = "split"
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.showmode = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.showmatch = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.updatetime = 100
vim.opt.timeoutlen = 400

vim.diagnostic.config({
	signs = true,
	underline = true,
	severity_sort = true,
	update_in_insert = true,
	virtual_text = {
		spacing = 2,
	},
	float = {
		focusable = false,
		source = true,
		style = "minimal",
		border = "rounded",
		header = "",
		prefix = "",
	},
})
