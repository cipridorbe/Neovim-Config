-- Load lspconfig
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
	vim.notify("Could not load lsp")
	return
end

-- Files to load
require("cipri.lsp.lsp-installer")
require("cipri.lsp.handlers").setup()
