-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd("packadd packer.nvim")
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

vim.cmd [[packadd packer.nvim]]

-- add list of plugins to install
return packer.startup(function(use)
	-- packer can manage itself
	use("wbthomason/packer.nvim")

    -- colorscheme
    use({
        "cpea2506/one_monokai.nvim",
        config = function()
            require("one_monokai").setup({
                italics = false,
            })
            -- vim.cmd("colo one_monokai")
        end
    })

	-- commenting with gc
	use("numToStr/Comment.nvim")

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { {'nvim-lua/plenary.nvim'} } }) -- fuzzy finder

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

    -- lualine config
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function()
                --[[
            --require("lualine").setup({})
                --]]
            require("lualine").setup({
                options = {
                    icons_enabled = false,
                }
            })
        end,
    }

	if packer_bootstrap then
		require("packer").sync()
	end
end)
