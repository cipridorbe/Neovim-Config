local g = vim.g
-- Tokyonight options
g.tokyonight_style = "storm"  -- storm, night or day
g.tokyonight_italic_comments = true

-- Try to use tokyonight as the colorscheme, if it is not available use evening colorscheme
vim.cmd[[
	try
		colorscheme tokyonight
	catch /.*/
		echo "tokyonight is not installed"
		colorscheme evening
]]
