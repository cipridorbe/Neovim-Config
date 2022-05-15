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
	"autopairs",
	"comments",
	"gitsigns",
	"nvimtree",
	"bufferline",
}

-- Actually source the files
for _, file in ipairs(files) do
	 require("cipri." .. file)
end
