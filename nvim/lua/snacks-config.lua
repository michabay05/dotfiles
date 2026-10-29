require("snacks").setup({
    indent = { enabled = true },
    lazygit = { enabled = true },
})

vim.keymap.set("n", "<leader>lg", function() Snacks.lazygit() end)
