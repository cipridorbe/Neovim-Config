local ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not ok then
	vim.notify("Could not load nvim-lsp-installer")
	return
end

-- This file is called by cipri/lsp/init.lua, which first makes sure lspconfig is installed
local lspconfig = require("lspconfig")

-- Servers to have installed
local servers = {
	"clangd", -- C/C++
	"jdtls", -- Java
	"sumneko_lua", -- Lua
	"pyright", -- Python
	"vimls", -- Vim
	"yamlls", -- Yml
}

-- Setup nvim-lsp-installer
lsp_installer.setup{
	-- Install the servers list
	ensure_installed = servers,
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗"
		},
		keymaps = {
			check_server_version = "v"  -- use "v" instead of "c"
		}
	}
}


-- Custom server settings found in server-settings.lua
local server_settings = require("cipri.lsp.server-settings")
-- Setup the lsp servers
for _, server in pairs(servers) do
	local opts = {
		on_attach = require("cipri.lsp.handlers").on_attach,
		capabilities = require("cipri.lsp.handlers").capabilities,
	}
	if type(server_settings[server]) ~= "nil" then
		opts = vim.tbl_deep_extend("keep", server_settings[server], opts)
	end
	-- Finally, set up the server
	lspconfig[server].setup(opts)
end
