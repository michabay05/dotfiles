local remap = vim.keymap.set

remap("n", "<leader>ll", ":VimtexCompile<CR>")

remap("n", "j", "gj")
remap("n", "k", "gk")
remap("n", "0", "g0")
remap("n", "$", "g$")

vim.lsp.config["texlab"] = {
    cmd = {"texlab"},
    filetypes = { "tex" },
}
vim.lsp.enable("texlab")
