-- Load toggleterm
local toggleterm_ok, toggleterm = pcall(require, "toggleterm")
if not toggleterm_ok then
	return
end

toggleterm.setup{
	-- double backslash because first escapes the second one
	open_mapping = "<C-\\>",
	start_in_insert = true,
	insert_mappings = true,
	terminal_mappings = true,
	-- Open as floating window
	direction = "float",
	float_opts = {
		border = "curved",
		winblend = 0,
	},
}

function _G.set_term_keymaps()
	local opts = {noremap = true}
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
	keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
	keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
	keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
	keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_term_keymaps()')

local terminal = require("toggleterm.terminal").Terminal

-- Lazygit
function _G.LazyGitToggle()
	terminal:new{
		cmd = "lazygit",
		hidden = true,
	}:toggle()
end

vim.cmd('command! LazyGit lua LazyGitToggle()')
