-- set leader key to space
vim.g.mapleader = " "

local remap = vim.keymap.set -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
-- remap("i", "jk", "<ESC>")

-- clear search highlights
remap("n", "<leader>h", ":nohl<CR>")

-- Terminal remap
-- vim.cmd([[tnoremap jk <C-\><C-n>]])
remap("t", "jk", [[<C-\><C-n>]])

-- Buffer specific navigation
remap("n", "gt", ":bn<CR>")
remap("n", "gT", ":bp<CR>")
remap("n", "<leader>c", ":bd!<CR>")

-- Window Navigation
remap("n", "<C-h>", "<C-w>h")
remap("n", "<C-j>", "<C-w>j")
remap("n", "<C-k>", "<C-w>k")
remap("n", "<C-l>", "<C-w>l")

-- Keep selected text while indenting and outdenting
remap("v", "<", "<gv")
remap("v", ">", ">gv")

-- Move lines up and down
remap("n", "<A-j>", ":m .+1<CR>==", { silent = true })
remap("n", "<A-k>", ":m .-2<CR>==", { silent = true })
remap("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
remap("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })

-- Copy lines up and down
remap("n", "<A-c>", ":co .<CR>==", { silent = true })

-- Copy and paste from system clipboard
remap({ "n", "v", "x" }, "<leader>y", '"+y')
remap({ "n", "v", "x" }, "<leader>p", '"+p')
remap({ "n", "v", "x" }, "<leader>P", '"+P')

-- Creating vertical and horizontal split
remap("n", "<leader>vs", ":vsplit<CR>")
remap("n", "<leader>hs", ":split<CR>")
