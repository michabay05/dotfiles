-- set leader key to space
vim.g.mapleader = " "

local remap = vim.keymap.set -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
remap("i", "jk", "<ESC>")

-- clear search highlights
remap("n", "<leader>h", ":nohl<CR>")

-- File explorer
-- remap("n", "<leader>e", ":Lexplore<CR>")

-- Buffer specific navigation
remap("n", "H", ":bp<CR>")
remap("n", "L", ":bn<CR>")
remap("n", "<leader>c", ":bd<CR>")

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
remap({ "n", "v" }, "<leader>y", [["+y]])
remap("n", "<leader>p", [["*p]])
remap("n", "<leader>P", [["*P]])
remap("v", "<leader>r", [["*p]])
remap("v", "<leader>R", [["*P]])

-- Creating vertical and horizontal split
remap("n", "<leader>vs", ":vsplit<CR>")
remap("n", "<leader>hs", ":split<CR>")

-- Closing split screen
remap("n", "<leader>x", ":quit<CR>")

----------------------
-- Plugin Keybinds
----------------------

-- telescope
remap("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
remap("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
remap("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
remap("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
remap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
remap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
remap("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
remap("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
remap("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]
