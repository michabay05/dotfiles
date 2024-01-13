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

require("lazy").setup({
    {
        "michabay05/gruber-darker.nvim",
        config = function()
            require("gruber-darker").setup {
                italic = {
                    strings = false,
                    comments = false,
                },
            }
            vim.cmd("colo gruber-darker")
        end,
    },

    "numToStr/Comment.nvim",

	{
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

	--[[ {
		"nvim-treesitter/nvim-treesitter",
		config = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	} ]]

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

    "tikhomirov/vim-glsl",

}, {})

--[[ require("lazy").setup({ { import = "josean.plugins" } }, {
    install = {
        colorscheme = { "gruber-darker" },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
}) ]]
