return {
    {
        "navarasu/onedark.nvim",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("onedark").setup {
                style = "darker",
                code_style = {
                    comments = "none"
                }
            }
            -- Enable theme
            require('onedark').load()
        end
    },

    "lewis6991/gitsigns.nvim",
    "preservim/vim-pencil",

    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({
                columns = {
                    "permissions",
                    "size",
                    "mtime",
                },
                -- Buffer-local options to use for oil buffers
                buf_options = {
                    buflisted = false,
                    bufhidden = "hide",
                },
                -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
                delete_to_trash = false,
                -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
                skip_confirm_for_simple_edits = true,
                -- Constrain the cursor to the editable parts of the oil buffer
                -- Set to `false` to disable, or "name" to keep it on the file names
                constrain_cursor = false,
                view_options = {
                    -- Show files and directories that start with "."
                    show_hidden = true,
                }
            })
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        end,
    },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
        lazy = false,
    },

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            animate = { enabled = false },
            bigfile = { enabled = true },
            dashboard = { enabled = false },
            explorer = { enabled = false },
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = false },
            statuscolumn = { enabled = true },
            win = { enabled = true },
        },
    },


    -- {
    --     "ej-shafran/compile-mode.nvim",
    --     tag = "v5.2.0",
    --     -- you can just use the latest version:
    --     -- branch = "latest",
    --     -- or the most up-to-date updates:
    --     -- branch = "nightly",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         -- if you want to enable coloring of ANSI escape codes in
    --         -- compilation output, add:
    --         -- { "m00qek/baleia.nvim", tag = "v1.3.0" },
    --     },
    --     config = function()
    --         vim.keymap.set("n", "<leader>bb", ":Compile<CR>")
    --         vim.keymap.set("n", "<leader>br", ":Recompile<CR>")
    --         vim.keymap.set("n", "<leader>bn", ":NextError<CR>")
    --         vim.keymap.set("n", "<leader>bp", ":PrevError<CR>")
    --         ---@type CompileModeOpts
    --         vim.g.compile_mode = {
    --             -- to add ANSI escape code support, add:
    --             -- baleia_setup = true,
    --         }
    --     end
    -- },

    { -- Fuzzy Finder (files, lsp, etc)
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { -- If encountering errors, see telescope-fzf-native README for installation instructions
                "nvim-telescope/telescope-fzf-native.nvim",

                -- `build` is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = "make",

                -- `cond` is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
            { "nvim-telescope/telescope-ui-select.nvim" },

            -- Useful for getting pretty icons, but requires a Nerd Font.
            { "nvim-tree/nvim-web-devicons" },
        },
        config = function()
            require("telescope").setup({
                defaults= {
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
                pickers = {
                    live_grep = {
                        additional_args = function(_)
                            return {}
                        end
                    },
                }
            })

            -- Enable Telescope extensions if they are installed
            pcall(require("telescope").load_extension, "fzf")
            pcall(require("telescope").load_extension, "ui-select")

            -- See `:help telescope.builtin`
            local builtin = require("telescope.builtin")
            local remap = vim.keymap.set
            remap("n", "<leader>ff", function()
                builtin.find_files({hidden = true})
            end)
            remap("n", "<leader>fk", builtin.keymaps)
            remap("n", "<leader>fs", builtin.grep_string)
            remap("n", "<leader>fh", builtin.help_tags)
            remap("n", "<leader>fg", builtin.live_grep)
            remap("n", "<leader>fd", builtin.diagnostics)
            remap("n", "<leader>fr", builtin.resume)
            remap("n", "<leader>f.", builtin.oldfiles)
            remap("n", "<leader><leader>", builtin.buffers)

            -- telescope git commands (not on youtube nvim video)
            remap("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
            remap("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
            remap("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
            remap("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

            -- Slightly advanced example of overriding default behavior and theme
            remap("n", "<leader>/", function()
                -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                    winblend = 10,
                    previewer = false,
                }))
            end)

            -- It's also possible to pass additional configuration options.
            --  See `:help telescope.builtin.live_grep()` for information about particular keys
            remap("n", "<leader>s/", function()
                builtin.live_grep({
                    grep_open_files = true,
                    prompt_title = "Live Grep in Open Files",
                })
            end)

            -- Shortcut for searching your Neovim configuration files
            remap("n", "<leader>sn", function()
                builtin.find_files({ cwd = vim.fn.stdpath("config") })
            end)
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "cpp", "lua", "zig", "rust", "vimdoc", "luadoc", "vim", "lua", "markdown" },
                auto_install = false,
                highlight = {
                    enable = true,
                    disable = { "c", "h", "cpp" },
                },
            })
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer", -- source for text in buffer
            "hrsh7th/cmp-path", -- source for file system paths
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip", -- snippet engine

            -- "saadparwaiz1/cmp_luasnip", -- for autocompletion
            -- "rafamadriz/friendly-snippets", -- useful snippets
            "onsails/lspkind.nvim", -- vs-code like pictograms
        },


        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            -- local lspkind = require("lspkind")

            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,preview,noselect",
                },

                snippet = { -- configure how nvim-cmp interacts with snippet engine
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                }),

                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "luasnip" }, -- snippets
                    { name = "buffer" }, -- text within current buffer
                    { name = "path" },
                }),

                -- -- configure lspkind for vs-code like pictograms in completion menu
                -- formatting = {
                --     format = lspkind.cmp_format({
                --         maxwidth = 50,
                --         ellipsis_char = "...",
                --     }),
                -- },
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
        end,
    },
}
