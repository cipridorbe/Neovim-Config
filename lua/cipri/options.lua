-- Table with options and their value
-- :help option-summary for all options
local options = {
	-- Make tab 4 characters long, and keep tab as tabs (don't convert to spaces)
	tabstop = 4,
	shiftwidth = 4,
	expandtab = false,
	smartindent = true,

	-- Allow mouse to be used, and highlight cursor row
	mouse = "a",
	cursorline = true,
	cursorlineopt = {"number",},  -- To highlight cursor row, and screenline to list 

	-- Display line numbers, and display errors and warning in the same column. Make this column 2 columns long by default
	number = true,
	relativenumber = false,
	signcolumn = "number",
	numberwidth = 2,

	-- Scrolloff and wrap configs
	scrolloff = 6,
	sidescrolloff = 6,
	wrap = false,

	-- Backup, swap and undo related configs.
	swapfile = false,
	undofile = true,

	-- Search related configs
	ignorecase = true,
	smartcase = true,
	incsearch = true,

	-- Turn on 24-bit colors
	termguicolors = true,

	-- Format options configs.
	-- TODO Removing default opts does not work
	formatoptions = '',
	formatoptions = 'q' .. 'l' .. '1' .. 'j',

	-- Other configs
	timeoutlen = 200,
	updatetime = 400,
	cmdheight = 2,
	fileencoding = "utf-8",
	pumheight = 13,
	compatible = false,
	splitright = true,
	splitbelow = true,
	wildmenu = true,
	wildmode = "list:longest",
	gdefault = true,

	-- Configs required by plugins
}

vim.cmd[[set formatoptions-=cro]]

-- Load the options
for option, value in pairs(options) do
	vim.opt[option] = value
end
