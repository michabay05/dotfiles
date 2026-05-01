return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "saghen/blink.cmp",
    },
    config = function()
        local blink_cmp = require("blink.cmp")
        local keymap = vim.keymap -- for conciseness
        local opts = { noremap = true, silent = true }
        local on_attach = function(_, bufnr)
            opts.buffer = bufnr

            vim.diagnostic.config({
                float = { border = "rounded" },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.INFO] = " ",
                        [vim.diagnostic.severity.HINT] = " "
                    }
                }
            })

            -- set keybinds
            opts.desc = "Show LSP references"
            keymap.set("n", "gR", vim.lsp.buf.references, opts) -- show definition, references

            opts.desc = "Show LSP definitions"
            keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- show lsp definitions

            opts.desc = "Show LSP implementations"
            keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

            opts.desc = "Rename current identifier"
            keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)

            opts.desc = "See available code actions"
            keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

            opts.desc = "Show buffer diagnostics"
            keymap.set("n", "gD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

            opts.desc = "Show line diagnostics"
            keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

            opts.desc = "Show documentation for what is under cursor"
            keymap.set("n", "K", function()
                vim.lsp.buf.hover({border = "rounded"})
            end, opts) -- show documentation for what is under cursor

            opts.desc = "Signature help"
            keymap.set("i", "<C-k>", function()
                vim.lsp.buf.signature_help()
            end, opts)

            opts.desc = "Restart LSP"
            keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
        end

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = blink_cmp.get_lsp_capabilities()

        local lsps = {
            "clangd",
            "jdtls",
            "pyright",
            "tinymist"
        }
        for _, lsp in ipairs(lsps) do
            vim.lsp.config(lsp, {
                capabilities = capabilities,
                on_attach = on_attach,
            })
        end

        -- configure lua server (with special settings)
        vim.lsp.config("lua_ls", {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = { -- custom settings for lua
                Lua = {
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        -- make language server aware of runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })

        table.insert(lsps, "lua_ls")
        vim.lsp.enable(lsps)
    end,
}
