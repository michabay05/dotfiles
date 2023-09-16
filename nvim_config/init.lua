-- NEOVIDE CONFIG
if vim.g.neovide then
    vim.o.guifont = "Iosevka Nerd Font Mono:h12"
	vim.g.neovide_scale_factor = 1.0
	vim.g.neovide_scroll_animation_length = 0.1
	vim.g.neovide_refresh_rate = 59
	vim.g.neovide_confirm_quit = true
	vim.g.neovide_cursor_animation_length = 0.005


	local scale_factor = 1.015
	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end
	vim.keymap.set("n", "<C-=>", function()
		change_scale_factor(scale_factor)
	end)
	vim.keymap.set("n", "<C-->", function()
		change_scale_factor(1 / scale_factor)
	end)
end

----------------------------------------
require("user.packer")
require("user.core.options")
require("user.core.keymaps")
require("user.plugins.comment")
require("user.plugins.treesitter")
