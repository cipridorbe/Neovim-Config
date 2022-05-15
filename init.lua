-- Files or directories to source. All in lua/cipri/
local files = {
	"options",
	"keymaps",
	"plugins",
	"colorscheme",
	"cmp",
	"lsp",
	"telescope",
	"treesitter",
}

-- Actually source the files
for _, file in ipairs(files) do
	require("cipri." .. file)
end
