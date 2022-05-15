local treesitter_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_ok then
	vim.notify("Could not load nvim-treesitter")
	return
end

treesitter.setup{
	ensure_installed = "all",
	sync_install = false,
	highlight = {
		enable = true,
		disable = {""},
		additional_vim_regex_highlighting = false,
	},
}
