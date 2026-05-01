return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colo tokyonight-night]])
        end,
    },

    {
        "chomosuke/typst-preview.nvim",
        ft = "typst", -- or lazy = false
        version = "1.*",
    },

    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({
                -- Buffer-local options to use for oil buffers
                buf_options = {
                    buflisted = false,
                    bufhidden = "hide",
                },
                delete_to_trash = false,
                skip_confirm_for_simple_edits = true,
                view_options = {
                    -- Show files and directories that start with "."
                    show_hidden = true,
                }
            })
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        end,
    },


    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            indent = { enabled = true },
            input = { enabled = true },
        },
    },

    {
        "nvim-mini/mini.nvim",
        version = '*',

        config = function()
            require("mini.comment").setup()
        end,
    },

    {
        "saghen/blink.cmp",
        -- optional: provides snippets for the snippet source
        -- dependencies = { "rafamadriz/friendly-snippets" },

        -- use a release tag to download pre-built binaries
        version = "1.*",
        opts = {
            keymap = { preset = "default" },
            appearance = {
                nerd_font_variant = "mono"
            },
            completion = { documentation = { auto_show = false } },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },

    { -- Fuzzy Finder (files, lsp, etc)
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
            { "nvim-telescope/telescope-ui-select.nvim" },

            { "nvim-tree/nvim-web-devicons" },
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    preview = { treesitter = false },
                    file_ignore_patterns = {
                        "node_modules", "build", "dist", "yarn.lock"
                    },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden"
                    },
                },
            })

            -- Enable Telescope extensions if they are installed
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")

            -- See `:help telescope.builtin`
            local builtin = require("telescope.builtin")
            local remap = vim.keymap.set
            remap("n", "<leader>f", function()
                builtin.find_files({hidden = true, noignore = true})
            end)
            remap("n", "<leader>tk", builtin.keymaps)
            remap("n", "<leader>th", builtin.help_tags)
            remap("n", "<leader>tg", builtin.live_grep)
            remap("n", "<leader>td", builtin.diagnostics)
            remap("n", "<leader><leader>", builtin.buffers)
            remap("n", "<leader>to", builtin.lsp_document_symbols)

            -- Slightly advanced example of overriding default behavior and theme
            remap("n", "<leader>/", function()
                -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                    winblend = 10,
                    previewer = false,
                }))
            end)

            -- Shortcut for searching your Neovim configuration files
            remap("n", "<leader>sn", function()
                builtin.find_files({ cwd = vim.fn.stdpath("config") })
            end)
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install { "c", "cpp", "odin", "python" }

            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "*" },
                callback = function()
                    local filetype = vim.bo.filetype
                    if filetype and filetype ~= "" then
                        local success = pcall(function()
                            vim.treesitter.start()
                        end)
                        if not success then
                            return
                        end
                    end
                end,
            })

        end,
    },

    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            -- import mason
            local mason = require("mason")

            -- enable mason and configure icons
            mason.setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    }
}
