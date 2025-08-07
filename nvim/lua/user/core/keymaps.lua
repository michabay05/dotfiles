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
-- Question: why is Netrw [RO] readonly???
-- remap("n", "<leader>e", ":Explore<CR>")

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

-- -- Quickfix List remaps
-- function MakeToQuickfix()
--     -- Run the :make command
--     vim.cmd("make")
--
--     -- Check if there are any errors in the quickfix list
--     -- if vim.fn.getqflist({}) ~= nil and not vim.tbl_isempty(vim.fn.getqflist()) then
--     -- if not vim.tbl_isempty(vim.fn.getqflist()) then
--     local exit_code = vim.v.shell_error
--     print("Compilation output: exit " .. exit_code)
--     if exit_code ~= 0 then
--         -- Open the quickfix list if there are errors
--         vim.cmd("copen")
--     else
--         -- Close the quickfix list if it's already open
--         vim.cmd("cclose")
--     end
-- end
-- -- Create a custom command to run MakeToQuickfix
-- vim.api.nvim_create_user_command("MakeToQuickfix", MakeToQuickfix, {})
-- remap("n", "<leader>b", ":MakeToQuickfix<CR><CR>", { noremap = true, silent = true })
-- remap("n", "b[", ":cprev<CR>")
-- remap("n", "b]", ":cnext<CR>")

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
