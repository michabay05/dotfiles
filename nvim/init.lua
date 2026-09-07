require("options")
require("keymaps")

vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim", version = "v2.16.0" },
    { src = "https://github.com/lervag/vimtex", version = "v2.18" },
    "https://github.com/nvim-treesitter/nvim-treesitter",

    "https://github.com/nvim-lua/plenary.nvim",
    -- NOTE: Go into the install dir and run 'make'
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
})

require("oil-config")
require("telescope-config")

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
