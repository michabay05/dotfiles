-- NOTE: Currently only 'terse-error' mode is supported.
vim.cmd([[ compiler odin ]])
vim.treesitter.start()

vim.keymap.set("n", "<leader>g", ":!odin run .<CR>")

-- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- vim.wo[0][0].foldmethod = 'expr'
