vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- launch program
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "[-] File Explorer" })
vim.keymap.set("n", "<leader>db", "<cmd>Alpha<CR>", { desc = "[D]ash[B]oard" })
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "[L]azy" })
vim.keymap.set("n", "<leader>M", "<cmd>Mason<CR>", { desc = "[M]ason" })

-- terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "[E]scape terminal insert mode" })
vim.keymap.set("n", "<leader>t", "<cmd>terminal<CR>", { desc = "[T]erminal" })

-- write to disk
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "[W]rite" })
vim.keymap.set("n", "<leader>wa", "<cmd>wa<CR>", { desc = "[W]rite [A]ll" })
--vim.keymap.set("n", "<leader>wq", "<cmd>wq<CR>", { desc = "[W]rite [Q]uit" })
--vim.keymap.set("n", "<leader>wqa", "<cmd>wqa<CR>", { desc = "[W]rite [Q]uit [A]ll" })

-- window navigation
--vim.keymap.set("n", "<leader>wh", "<C-w><C-h>", { desc = "[W]indow [H] Left" })
--vim.keymap.set("n", "<leader>wj", "<C-w><C-j>", { desc = "[W]indow [J] Down" })
--vim.keymap.set("n", "<leader>wk", "<C-w><C-k>", { desc = "[W]indow [K] Up" })
--vim.keymap.set("n", "<leader>wl", "<C-w><C-l>", { desc = "[W]indow [L] Right" })

-- buffer navigation
vim.keymap.set("n", "<leader>bn", "<cmd>bn<CR>", { desc = "[B]uffer [N]ext" })
vim.keymap.set("n", "<leader>bp", "<cmd>bp<CR>", { desc = "[B]uffer [P]rev" })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "[B]uffer [D]elete" })
vim.keymap.set("n", "<leader>bw", "<cmd>bw!<CR>", { desc = "[B]uffer [W]ipeout" })

-- list navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "[C-k] Next Quickfix Item" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "[C-j] Prev Quickfix Item" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "[K] Next Location Item" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "[J] Prev Location Item" })

-- move the lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "[J] Move Line Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "[K] Move Line Up" })

-- center the action
vim.keymap.set("n", "J", "mzJ`z", { desc = "[J] Join Lines" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "[C-d] Half Page Down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "[C-u] Half Page Up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "[n] Next Search" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "[N] Prev Search" })

-- to the void
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "[D]elete to Void" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "[P]aste over Void" })

-- system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[Y]ank to System Clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank Line to System Clipboard" })
vim.keymap.set("n", "<leader>P", [["+P]], { desc = "[P]aste Before (Clipboard)" })
vim.keymap.set("n", "<leader>p", [["+p]], { desc = "[p]aste After (Clipboard)" })

-- misc
vim.keymap.set("n", "<leander>nh", "<cmd>nohl<CR>", { desc = "[N]o [H]ighlight" })
vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "[S]earch and replace current carret word" }
)

-- don't want this
vim.keymap.set("n", "Q", "<nop>")
