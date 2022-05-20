-- Make sure lualine is properly installed
local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
	vim.notify("Failed to load lualine")
	return
end

-- Tables to use in sections part of setup
-- Mode to display in left.
local mode = {
	"mode",
	padding = 1,
	fmt = function(str)
		return (vim.fn.winwidth(0) < 80 and str:sub(1, 1) or str)
	end,
}

-- Only show errors and warnings in diagnostics
local diagnostics = {
	"diagnostics",
	sources = {"nvim_diagnostic"},
	sections = {"error", "warn"},
	symbols = {error = " ", warn = " "},
	always_visible = true,
}

-- Use gitsigns as diff source
local diff = {
	"diff",
	symbols = {added = " ", modified = " ", removed = " "},
	source = function()
		local gitsigns = vim.b.gitsigns_status_dict
		if gitsigns then
			return {
				added = gitsigns.added,
				modified = gitsigns.changed,
				removed = gitsigns.removed
			}
		end
	end,
	cond = function() return vim.fn.winwidth(0) > 60 end
}

-- Filename options
local filename = {
	"filename",
	symbols = {modified = '  ', readonly = ' ', unnamed = "[No Name]"},
	cond = function() return vim.fn.winwidth(0) > 45 end
}

-- Hide encoding and fileformat when screenwidth is less than 80
local encoding = {
	"encoding",
	cond = function() return vim.fn.winwidth(0) > 70 end,
}
local fileformat = {
	"fileformat",
	cond = function() return vim.fn.winwidth(0) > 70 end,
}

-- Hide filetype on short widths
local filetype = {
	"filetype",
	cond = function() return vim.fn.winwidth(0) > 52 end,
}

-- Display location with 1 space to each side
local location = function()
	return vim.fn.line('.') .. ':' .. vim.fn.col('.')
end

-- Display progress with 1 space to each side
local progress = function()
	return math.ceil(vim.fn.line('.') / vim.fn.line('$') * 100) .. '%%'
end

-- The setup function. Needed
lualine.setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		-- Don't use component separators
		component_separators = {left = '', right = ''},
		section_separators = {left = '', right = ''},
		-- Don't use lualine on this filetypes (:echo &filetype to see current filetype)
		disabled_filetypes = {"alpha"},
		always_divide_middle = true,
		globalstatus = false,
	},
	sections = {
		lualine_a = {mode},
		lualine_b = {'branch', diff, diagnostics},
		lualine_c = {filename},
		lualine_x = {encoding, fileformat, filetype},
		lualine_y = {location},
		lualine_z = {progress}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},
	extensions = {
		"nvim-tree",
		"toggleterm",
	},
}
