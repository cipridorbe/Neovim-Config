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

	-- Icons for plugins
	use "kyazdani42/nvim-web-devicons"
	use "ryanoasis/vim-devicons"

	-- Colorschemes
	use "folke/tokyonight.nvim"
	use "LunarVim/darkplus.nvim"
	use "LunarVim/onedarker.nvim"

	-- Autocomplete with cmp
	use "hrsh7th/nvim-cmp" -- The completion plugin
	use "hrsh7th/cmp-buffer" -- Buffer completions
	use "hrsh7th/cmp-path" -- Path completions
	use "hrsh7th/cmp-cmdline" -- Cmdline completions
	use "saadparwaiz1/cmp_luasnip" -- Snippet completions with luasnip
	use "hrsh7th/cmp-nvim-lsp" -- Lsp completion
	use "hrsh7th/cmp-nvim-lua" -- Vim api for lua completion

	-- Snippets
	use "L3MON4D3/LuaSnip" -- Snippet engine
	use "rafamadriz/friendly-snippets" -- A lot of snippets to use

	-- LSP
	use "neovim/nvim-lspconfig" -- LSP
	use "williamboman/nvim-lsp-installer" -- Language server installer

	-- Telescope and extensions
	use "nvim-telescope/telescope.nvim"
	use {"nvim-telescope/telescope-fzf-native.nvim", run = 'make'}

	-- Treesitter
	use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

	-- Autopairs
	use "windwp/nvim-autopairs"

	-- Comments
	use "numToStr/Comment.nvim"
	use "JoosepAlviste/nvim-ts-context-commentstring"

	-- Gitsigns (git column in the left)
	use "lewis6991/gitsigns.nvim"

	-- Set up config automatically after plugin installation
	if packer_bootstrap then
		require('packer').sync()
	end
end)
