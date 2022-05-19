-- Load the plugin
local indentline_ok, indentline = pcall(require, "indent_blankline")
if not indentline_ok then
	return
end

indentline.setup{
	filetype_exclude = {
		"lspinfo",
		"packer",
		"checkhealth",
		"help",
		"man",
		"TelescopePrompt",
		"NvimTree",
	},
	char = '▏',
	use_treesitter = true,
	show_current_context = true,
	show_trailing_blankline_indent = false,
}
