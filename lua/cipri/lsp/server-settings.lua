local server_settings = {}

-- Lua server settings
server_settings.sumneko_lua = {
	settings = {
		Lua = {
			diagnostics = {
				globals = {"vim"},
			}
		}
	}
}


return server_settings
