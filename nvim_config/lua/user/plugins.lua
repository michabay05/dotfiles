-- Set colorscheme
-- vim.cmd([[colo habamax]])

local function nvim_tree_config()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- optionally enable 24-bit colour
    vim.opt.termguicolors = true

    require("nvim-tree").setup({
        sort = {
            sorter = "case_sensitive",
        },
        view = { width = 35 },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = false,
        },
    })
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
end

return {
    --[[ {
        "michabay05/gruber-darker.nvim",
        priority = 100,
        config = function()
            require("gruber-darker").setup {
                italic = {
                    strings = false,
                    comments = false,
                },
            }
            vim.cmd("colo gruber-darker")
        end,
    }, ]]

    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require("gruvbox").setup({
                italic = {
                    strings = false,
                },
                contrast = "hard"
            })
            vim.cmd("colo gruvbox")
        end,
    },

    --[[ {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
                    comments = { }, -- Change the style of comments
                    conditionals = { },
                }
            })
            vim.cmd("colo catppuccin")
        end,
    }, ]]

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
        lazy = false,
    },

    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup {
                options = {
                    icons_enabled = true,
                },
                sections = {
                    lualine_c = {
                        {
                            "filename",
                            -- 0: Just the filename
                            -- 1: Relative path
                            -- 2: Absolute path
                            -- 3: Absolute path, with tilde as the home directory
                            -- 4: Filename and parent dir, with tilde as the home directory
                            path = 1,
                        }
                    },
                }
            }
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = false,

                -- List of parsers to ignore installing (or "all")
                ignore_install = { "javascript" },

                ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
                -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

                highlight = {
                    enable = true,

                    disable = function(lang, buf)
                        if lang == "glsl" then
                            return true
                        end
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                }
            })
        end,
    },

    "tikhomirov/vim-glsl",
    "tpope/vim-fugitive",
    "preservim/vim-pencil",

    -- File explorere
    {
        "nvim-tree/nvim-tree.lua",
        config = nvim_tree_config,
    },

    -- Lua
    {
        "folke/zen-mode.nvim",
        lazy = true,
        ft = "markdown",
    },

    {
        "epwalsh/obsidian.nvim",
        version = "*",  -- recommended, use latest release instead of latest commit
        lazy = true,
        event = {
            --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
            --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
            -- "BufReadPre path/to/my-vault/**.md",
            -- "BufNewFile path/to/my-vault/**.md",
            "BufReadPre " .. vim.fn.expand "~" .. "/Documents/Obsidian-Notes**.md",
            "BufNewFile " .. vim.fn.expand "~" .. "/Documents/Obsidian-Notes**.md",
        },
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",

            -- see below for full list of optional dependencies 👇
        },
        config = function()
            require("obsidian").setup({
                workspaces = {
                    {
                        name = "personal",
                        path = "~/Documents/Obsidian-Notes",
                    },
                },
                disable_frontmatter = true
            })
        end,
    },

    -- Completion config
    "stevearc/dressing.nvim",

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer", -- source for text in buffer
            "hrsh7th/cmp-path", -- source for file system paths
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip", -- snippet engine
            --
            -- "saadparwaiz1/cmp_luasnip", -- for autocompletion
            -- "rafamadriz/friendly-snippets", -- useful snippets
            "onsails/lspkind.nvim", -- vs-code like pictograms
        },

        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")

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
                    { name = "luasnip" }, -- snippets
                    { name = "buffer" }, -- text within current buffer
                    { name = "path" },
                }),

                -- configure lspkind for vs-code like pictograms in completion menu
                formatting = {
                    format = lspkind.cmp_format({
                        maxwidth = 50,
                        ellipsis_char = "...",
                    }),
                },
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end,
    },
}
