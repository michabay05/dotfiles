----------------------------------------
        -- OPTION SECTION --
----------------------------------------
vim.o.updatetime = 200
vim.o.colorcolumn = "100"
vim.o.timeoutlen = 300
vim.o.showmode = false
vim.o.relativenumber = true -- show relative line numbers
vim.o.number = true -- shows absolute line number on cursor line (when relative number is on)
vim.o.tabstop = 4 -- 2 spaces for tabs (prettier default)
vim.o.shiftwidth = 4 -- 2 spaces for indent width
vim.o.expandtab = true -- expand tab to spaces
vim.o.autoindent = true -- copy indent from current line when starting new one
vim.o.wrap = true -- disable line wrapping
vim.o.ignorecase = true -- ignore case when searching
vim.o.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.inccommand = "split"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.cursorline = true  -- highlight the current cursor line
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5
vim.o.termguicolors = true
vim.o.background = "dark" -- colorschemes that can be light or dark will be made dark
vim.o.signcolumn = "yes" -- show sign column so that text doesn't shift
vim.o.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
vim.o.clipboard = ""
vim.o.splitright = true -- split vertical window to the right
vim.o.splitbelow = true -- split horizontal window to the bottom
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

----------------------------------------
      -- KEY BINDINGS SECTION --
----------------------------------------
-- set leader key to space
vim.g.mapleader = " "

local remap = vim.keymap.set -- for conciseness
remap("i", "jk", "<ESC>")
remap("n", "<leader>h", ":nohl<CR>")
remap("t", "jk", [[<C-\><C-n>]])
remap("n", "gt", ":bn<CR>")
remap("n", "gT", ":bp<CR>")
remap("n", "<leader>c", ":bd!<CR>")
remap("n", "<C-h>", "<C-w>h")
remap("n", "<C-j>", "<C-w>j")
remap("n", "<C-k>", "<C-w>k")
remap("n", "<C-l>", "<C-w>l")
remap("v", "<", "<gv")
remap("v", ">", ">gv")
remap("n", "<A-j>", ":m .+1<CR>==", { silent = true })
remap("n", "<A-k>", ":m .-2<CR>==", { silent = true })
remap("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
remap("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })
remap("n", "<A-c>", ":co .<CR>==", { silent = true })
remap({ "n", "v", "x" }, "<leader>y", '"+y')
remap({ "n", "v", "x" }, "<leader>p", '"+p')
remap({ "n", "v", "x" }, "<leader>P", '"+P')
remap("n", "<leader>vs", ":vsplit<CR>")
remap("n", "<leader>hs", ":split<CR>")


----------------------------------------
        -- PLUGINS SECTION --
----------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        -- "deparr/tairiki.nvim",
        "UtkarshVerma/molokai.nvim",
        config = function()
            -- vim.cmd([[ colo tairiki ]])
            vim.cmd([[ colo molokai ]])
        end,
    },

    {
        "tpope/vim-dispatch",
        config = function()
            remap("n", "<C-g>", ":Make<CR>:Copen<CR>")
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
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
        end
    },

    {
        "stevearc/aerial.nvim",
        config = function()
            require("aerial").setup({
                backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
                filter_kind = {
                    "Function",
                    "Struct",
                    "Constant",
                    "Enum",
                },
            })
        end,
    },

    {
        "stevearc/quicker.nvim",
        ft = "qf",
        opts = {},
    },

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
            remap("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        end,
    },

    {
        "chomosuke/typst-preview.nvim",
        lazy = false, -- or ft = "typst"
        version = "1.*",
        opts = {}, -- lazy.nvim will implicitly calls `setup {}`
    },

    {
        "nvim-mini/mini.nvim",
        version = "*",
        config = function()
            local hipatterns = require("mini.hipatterns")
            hipatterns.setup({
                highlighters = {
                    -- Highlight standalone "FIXME", "HACK", "TODO", "NOTE"
                    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
                    hack  = { pattern = "%f[%w]()HACK()%f[%W]",  group = "MiniHipatternsHack"  },
                    todo  = { pattern = "%f[%w]()TODO()%f[%W]",  group = "MiniHipatternsTodo"  },
                    note  = { pattern = "%f[%w]()NOTE()%f[%W]",  group = "MiniHipatternsNote"  },

                    -- Highlight hex color strings (`#rrggbb`) using that color
                    hex_color = hipatterns.gen_highlighter.hex_color(),
                },
            })

            require("mini.comment").setup()
            require("mini.sessions").setup()
            require('mini.align').setup()
        end,
    },

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below

            -- animate = { enabled = true },
            bigfile = { enabled = true },
            -- dashboard = { enabled = true },
            -- explorer = { enabled = false },
            indent = { enabled = true },
            input = { enabled = true },
            -- picker = { enabled = false },
            quickfile = { enabled = true },
            scope = { enabled = true },
            -- scroll = { enabled = false },
            statuscolumn = { enabled = true },
            win = { enabled = true },
        },
    },

    {
        "nvim-telescope/telescope.nvim", version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- optional but recommended
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },

        extensions = {
            aerial = {
                -- Set the width of the first two columns (the second
                -- is relevant only when show_columns is set to 'both')
                col1_width = 4,
                col2_width = 30,
                -- How to format the symbols
                format_symbol = function(symbol_path, filetype)
                    if filetype == "json" or filetype == "yaml" then
                        return table.concat(symbol_path, ".")
                    else
                        return symbol_path[#symbol_path]
                    end
                end,
                -- Available modes: symbols, lines, both
                show_columns = "both",
            },

            fzf = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = true,  -- override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            }
        },

        config = function()
            require("telescope").setup({
                defaults= {
                    file_ignore_patterns = {
                        "node_modules", "build", "dist", "yarn.lock",
                        ".git"
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
            require('telescope').load_extension("fzf")
            require("telescope").load_extension("aerial")
            remap("n", "<leader>o", ":Telescope aerial<CR>")

            local builtin = require("telescope.builtin")
            remap("n", "<leader>f", function()
                builtin.find_files({hidden = true, noignore = true})
            end)

            remap("n", "<leader>th", builtin.help_tags)
            remap("n", "<leader>tg", builtin.live_grep)
            remap("n", "<leader>td", builtin.diagnostics)
            remap("n", "<leader><leader>", builtin.buffers)

            remap("n", "<leader>/", function()
                -- You can pass additional configuration to Telescope to change the theme, layout, etc.
                builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                    winblend = 10,
                    previewer = false,
                }))
            end)

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
}

require("lazy").setup(plugins, {
    checker = {
        enabled = false,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
})

if vim.g.neovide then
    vim.g.neovide_scroll_animation_length = 0.1
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_confirm_quit = true
    vim.g.neovide_cursor_animation_length = 0.001
    vim.opt.linespace = 1

    vim.g.neovide_scale_factor = 1.0
    local scale_ratio = 1.05
    local change_scale_factor = function(delta)
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-=>", function()
      change_scale_factor(scale_ratio)
    end)
    vim.keymap.set("n", "<C-->", function()
      change_scale_factor(1/scale_ratio)
    end)
end

