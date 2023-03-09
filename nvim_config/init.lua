-- NEOVIDE CONFIG
if vim.g.neovide then
	vim.o.guifont = "Iosevka Nerd Font Mono:h11"
	vim.g.neovide_scale_factor = 1.0
	vim.g.neovide_scroll_animation_length = 0.1
	vim.g.neovide_refresh_rate = 59
	vim.g.neovide_confirm_quit = true
	vim.g.neovide_cursor_animation_length = 0

<<<<<<< HEAD
  vim.g.neovide_scale_factor = 1.0

  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1/1.25)
  end)

=======
	vim.g.neovide_scale_factor = 1.0

	local change_scale_factor = function(delta)
		vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	end
	vim.keymap.set("n", "<C-=>", function()
		change_scale_factor(1.25)
	end)
	vim.keymap.set("n", "<C-->", function()
		change_scale_factor(1 / 1.25)
	end)
>>>>>>> 35e131e (Worked on configuring go lsp)
end

----------------------------------------
require("user.packer")
require("user.core.options")
require("user.core.keymaps")
require("user.core.colorscheme")
require("user.plugins.comment")
require("user.plugins.nvim-tree")
require("user.plugins.lualine")
require("user.plugins.telescope")
require("user.plugins.nvim-cmp")
require("user.plugins.mason")
require("user.plugins.lspsaga")
require("user.plugins.lspconfig")
require("user.plugins.null-ls")
require("user.plugins.autopairs")
require("user.plugins.treesitter")
require("user.plugins.gitsigns")
