-- Plugin installation using packer
-- https://github.com/wbthomason/packer.nvim

local fn = vim.fn

-- automatically install packer if it is not installed
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootrsap = fn.system({
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		install_path
	})
	print("Installing packer. Close and reopen Neovim")
	vim.cmd[[packadd packer.nvim]]
end

-- Reaload neovim when saving this file
vim.cmd[[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]]

-- Use protected call to prevent errors
local ok, packer = pcall(require, "packer")
if not ok then
	return
end

-- Use popup window rather than actual window
packer.init{
	display = {
		open_fn = function()
			return require("packer.util").float{border = "rounded"}
		end
	}
}

-- IMPORTANT PART IS HERE
-- Plugin installation
return packer.startup(function(use)
	-- Plugins go here
	-- Packer and plugins required by other plugins
	use "wbthomason/packer.nvim" -- Have packer manage itself
	use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
	use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

	-- Colorschemes
	use "folke/tokyonight.nvim"
	use "LunarVim/darkplus.nvim"
	use "LunarVim/onedarker.nvim"


	-- Set up config automatically after plugin installation
	if packer_bootstrap then
		require('packer').sync()
	end
end)
