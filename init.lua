-- Files to source. All in lua/cipri/
local files = {
	"options",
}

-- Actually source the files
for _, file in ipairs(files) do
	require("cipri." .. file)
	vim.g.abcde = 10
end
