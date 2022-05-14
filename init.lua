-- Files or directories to source. All in lua/cipri/
local files = {
	"options",
	"keymaps",
	"plugins",
	"colorscheme",
	"cmp",
	"lsp",
	"telescope",
}

-- Actually source the files
for _, file in ipairs(files) do
	require("cipri." .. file)
end
