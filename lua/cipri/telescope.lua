-- Make sure telescope is installed
local ok, telescope = pcall(require, "telescope")
if not ok then
	vim.notify("Failed to load telescope")
	return
end

local actions = require("telescope.actions")

-- Telescope setup
telescope.setup{
	defaults = {
		prompt_prefix = ' ',
		selection_caret = ' ',
		path_display = {truncate = 1},
		preview = {
			msg_bg_fillchar = "#",
		},
		-- Mappings inside of the telescope prompt
		mappings = {
			i = {
				-- Movement
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				-- History
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
				-- Ctrl s to open a horizontal split
				["<C-s>"] = actions.select_horizontal

			},
			n = {
				["<C-s>"] = actions.select_horizontal,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
		}
	},
}

-- Load extensions
telescope.load_extension('fzf')
