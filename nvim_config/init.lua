require("user.core.options")
require("user.core.keymaps")
require("user.packer")
require("user.plugins.comment")
require("user.plugins.treesitter")

-------------------------------------------------

-- NEOVIDE CONFIG
if vim.g.neovide then
    vim.o.guifont = "Iosevka:h11"
    vim.g.neovide_scroll_animation_length = 0
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_confirm_quit = true
    vim.g.neovide_cursor_animation_length = 0.005

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
-------------------------------------------------

-- Make the cursor block if not in neovide
vim.cmd([[ set guicursor= ]])
