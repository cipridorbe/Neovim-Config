-- Files to source. All in lua/cipri/
local files = {
	"options",
	"keymaps",
	"plugins",
	"colorscheme",
	"cmp",
}

-- Actually source the files
for _, file in ipairs(files) do
	require("cipri." .. file)
end
