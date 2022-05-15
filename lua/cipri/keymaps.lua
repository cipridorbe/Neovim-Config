-- https://neovim.io/doc/user/map.html#map-table
-- Facilitate making keymaps
local M = {}
local opts = {noremap = true, silent = true,}
local termopts = {silent = true,}
local keymap = vim.api.nvim_set_keymap
local function NBind(key, value)
	keymap('n', key, value, opts)
end

-- Leader as space key
keymap('', "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Use semicolon to avoid pressing shift
keymap('', ";", ":", {})

-- Window movement
NBind("<C-h>", "<C-w>h")
NBind("<C-j>", "<C-w>j")
NBind("<C-k>", "<C-w>k")
NBind("<C-l>", "<C-w>l")

-- Window resizing
NBind("<C-Up>", "<cmd>resize +2<CR>")
NBind("<C-Down>", "<cmd>resize -2<CR>")
NBind("<C-Right>", "<cmd>vertical resize +2<CR>")
NBind("<C-Left>", "<cmd>vertical resize -2<CR>")

-- Alt H and L to switch buffers
NBind("<A-H>", "<cmd>bprev<CR>")
NBind("<A-L>", "<cmd>bnext<CR>")

-- Use H and L to move to start and end of line
keymap('', "H", "^", opts)
keymap('', "L", "g_", opts)


-- Alt J and K to move a line up or down
keymap('n', "<A-k>", ":move -2<CR>==", opts)
keymap('n', "<A-j>", ":move +1<CR>==", opts)
keymap('x', "<A-k>", ":move '<-2<CR>gv=gv", opts)
keymap('x', "<A-j>", ":move '>+1<CR>gv=gv", opts)
keymap('i', "<A-k>", "<Esc>:move -2<CR>==gi", opts)
keymap('i', "<A-j>", "<Esc>:move +1<CR>==gi", opts)

-- Stay in visual mode after indenting
keymap('v', ">", ">gv", opts)
keymap('v', "<", "<gv", opts)

-- When pasting over something selected in visual mode, don't copy selected text
keymap('v', "p", '"_dP', opts)

-- Fast quit and save
keymap('n', "<C-q>", ":x<CR>", opts)
keymap('i', "<C-q>", "<C-o>:x<CR>", opts)
keymap('n', "<C-s>", ":w<CR>", opts)
keymap('i', "<C-s>", "<C-O>:w<CR>", opts)

-- Horizontal movement
NBind("<A-]>", "z5l")
NBind("<A-[>", "z5h")

-- Yank to end of line
NBind("Y", "y$")

-- Yank path to clipboard
NBind("<leader>y", ":let @+=expand(\"%:~:.\")<CR>:echo 'Yanked relative path'<CR>")
NBind("<leader>Y", ":let @+=expand(\"%:p\")<CR>:echo 'Yanked absolute path'<CR>")

-- x and X don't copy to register when in normal mode
NBind("x", '"_x')
NBind("X", '"_X')

-- Replace selected text. Overrides h register
keymap('v', "<leader>r", "\"hy:<C-u>%s/<C-r>h//gc<Left><Left><Left>", {noremap = true})

-- Alt y or p to copy to system clipboard
keymap('', "<A-y>", '"*y', opts)
keymap('', "<A-yy>", '"*yy', opts)
keymap('', "<A-p>", '"*p', opts)

-- Plugin keymaps
-- cmp
local cmp_ok, cmp = pcall(require, "cmp")
local luasnip_ok, luasnip = pcall(require, "luasnip")
if cmp_ok and luasnip then
	cmp.setup{
		mapping = {
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),	
			["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
			["<C-e>"] = cmp.mapping {
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			},
			-- Accept currently selected item. If none selected, `select` first item.
			-- Set `select` to `false` to only confirm explicitly selected items.
			["<CR>"] = cmp.mapping.confirm {select = false},
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
		"i",
		"s",
		}),
		}
	}
end


-- Keymaps for lspconfig
M.LSP_keymaps = function(bufnr)
	local bkey = vim.api.nvim_buf_set_keymap
	-- Keymaps
	bkey(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	bkey(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	bkey(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	bkey(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	bkey(bufnr, 'n', 'S', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	bkey(bufnr, 'i', '<C-l>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	-- bkey(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	-- bkey(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	-- bkey(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	bkey(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	bkey(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	-- bkey(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	-- bkey(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	-- bkey(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	-- Extras
	bkey(bufnr, 'n', '<d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	bkey(bufnr, 'n', '>d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	bkey(bufnr, 'n', 'gl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics<CR>', opts)
	-- :Format to format
	vim.cmd[[command! Format execute 'lua vim.lsp.buf.formatting()']]
end

-- Telescope keymaps
local telescope_ok, telescope = pcall(require, "telescope")
if telescope_ok then
	NBind("<leader>tt", "<cmd>Telescope find_files<CR>")
	NBind("<leader>tl", "<cmd>Telescope live_grep<CR>")
	NBind("<leader>tb", "<cmd>Telescope buffers<CR>")
	NBind("gr", "<cmd>Telescope lsp_references<CR>")
	NBind("<leader>tb", "<cmd>Telescope current_buffer_fuzzy_find<CR>")
end

-- NvimTree keymaps
local nvimtree_ok, nvim_tree = pcall(require, "nvim-tree")
if nvimtree_ok then
	NBind('<leader>e', '<cmd>NvimTreeToggle<CR>')
end

return M
