require("blink.cmp").setup({
    keymap = { preset = "default" },
    appearance = {
        nerd_font_variant = "normal"
    },
    completion = { documentation = { auto_show = false } },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
})

vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities({}),
})

