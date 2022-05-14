-- Table to return at the end of file
local M = {}

-- Fill table
M.setup = function()
	-- Icons to be used. https://www.nerdfonts.com/cheat-sheet
	local icons = {
		{name = "DiagnosticSignError", text = "" },
		{name = "DiagnosticSignWarn", text = "" },
		{name = "DiagnosticSignHint", text = "" },
		{name = "DiagnosticSignInfo", text = "" },
	}
	for _, icon in ipairs(icons) do
		vim.fn.sign_define(icon.name, {texthl = icon.name, text = icon.text, numhl = ""})
	end

	-- Config to pass to vim.diagnostic.config()
	local config = {
		-- show the signs
		signs = {
			active = true,
		},
		-- Make diagnositcs update while in insert mode
		update_in_insert = true,
		-- Sort diagnostics by severity
		severity_sort = true,
		-- Floating window configs
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	-- Apply this config
	vim.diagnostic.config(config)

	-- Configs for particular methods
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})


	-- Command to toggle virtual text
	local virtual_text = true
	function _G.toggle_diagnotics()
		vim.diagnostic.config({virtual_text = not virtual_text})
		virtual_text = not virtual_text
	end
	vim.cmd("command! ToggleVirtualText call v:lua.toggle_diagnotics()")
end

-- Function to highlight when hovering over text
local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
		[[
		augroup lsp_document_highlight
		autocmd! * <buffer>
		autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
		autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
		]],
		false
		)
	end
end

-- Implementation in lua/cipri/keymaps.lua
local lsp_keymaps = require("cipri.keymaps").LSP_keymaps

-- On attach function for lspconfig server setup
M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end

-- Capabilities for cmp-nvim-lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	vim.notify("Could not load cmp_nvim_lsp inside lsp/handlers.lua")
	return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
