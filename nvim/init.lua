require("options")
require("keymaps")

vim.pack.add({
    "https://github.com/blazkowolf/gruber-darker.nvim",
    "https://github.com/stevearc/overseer.nvim",

    { src = "https://github.com/stevearc/oil.nvim", version = "v2.16.0" },
    "https://github.com/nvim-treesitter/nvim-treesitter",

    "https://github.com/nvim-lua/plenary.nvim",
    -- NOTE: Go into the install dir and run 'make'
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-telescope/telescope-file-browser.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",

    "https://github.com/jake-stewart/multicursor.nvim",
    { src = "https://github.com/nvim-mini/mini.nvim", version = "stable" },
    { src = "https://github.com/folke/snacks.nvim", version = "v2.31.0" },
    { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
    "https://github.com/rafamadriz/friendly-snippets",
    { src = "https://github.com/chomosuke/typst-preview.nvim", version = "v1.5.0" },
})

vim.cmd.colorscheme("gruber-darker")

require("oil-config")
require("telescope-config")
require("mc-config")
require("mini-config")
require("snacks-config")
require("lsp-config")
require("overseer-config")


vim.g.vimtex_view_general_viewer = "okular"
vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]

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

-- NEOVIDE CONFIG
if vim.g.neovide then
    vim.g.neovide_scroll_animation_length = 0.1
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_confirm_quit = true
    vim.g.neovide_cursor_animation_length = 0.005
    vim.opt.linespace = 0

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
