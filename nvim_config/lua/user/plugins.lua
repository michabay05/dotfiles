-- Set colorscheme
-- vim.cmd([[colo habamax]])

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
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedark").setup({
                style = "warm",
                code_style = {
                    comments = "none"
                }
            })
            vim.cmd("colo onedark")
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
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup {
                options = {
                    icons_enabled = false,
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
        dependencies = { "nvim-lua/plenary.nvim" },
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

                    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
                    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
                    -- the name of the parser)
                    -- list of language that will be disabled
                    disable = { "glsl" },
                    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                    disable = function(lang, buf)
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
}
