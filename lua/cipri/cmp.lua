-- Load cmp and luasnip
local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
	vim.notify("Could not load cmp")
	return
end

local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then
	vim.notify("Could not load luasnip")
	return
end

-- Load some plugins
require("luasnip/loaders/from_vscode").lazy_load()

-- Icons to use in menu
local icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

-- Setup
cmp.setup{
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
	-- Keymaps in keymaps.lua
	sources = {
		{name = "nvim_lsp"},
		{name = "nvim_lua"},
		{name = "luasnip"},
		{name = "buffer"},
		{name = "path"},
	},
	formatting = {
		fields = {"kind", "abbr", "menu"},
		format = function(entry, vim_item)
			-- Icons
			vim_item.kind = string.format("%s", icons[vim_item.kind])
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				nvim_lua = "[NVIM_LUA]",
				luasnip = "[Snip]",
				buffer = "[Buff]",
				path = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	},
	window = {
		documentation = cmp.config.window.bordered(),
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{name = 'buffer'}
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{name = 'path'},
		{ name = 'cmdline'}
	})
})
