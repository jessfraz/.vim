-- Exercise the actual configured ripgrep commands through Telescope's config.
local plugins = dofile("lua/plugins.lua")
for _, plugin in ipairs(plugins) do
	if plugin[1] == "nvim-telescope/telescope.nvim" then
		plugin.config()
	end
end

local root = vim.fn.tempname()
local files = {
	"src/main.lua",
	".github/workflows/ci.yml",
	".hidden",
	"docs/html/generated.html",
	".git/objects/blob",
	"ignored.txt",
}
for _, path in ipairs(files) do
	vim.fn.mkdir(vim.fs.dirname(root .. "/" .. path), "p")
	vim.fn.writefile({ "search-fixture" }, root .. "/" .. path)
end
vim.fn.writefile({ "ignored.txt" }, root .. "/.gitignore")
vim.fn.chdir(root)

local function assert_search(command)
	local results = vim.fn.systemlist(command)
	assert(vim.v.shell_error == 0, table.concat(results, "\n"))
	local found = {}
	for _, path in ipairs(results) do
		found[path] = true
	end
	for _, path in ipairs({ "src/main.lua", ".github/workflows/ci.yml", ".hidden" }) do
		assert(found[path], "Search omitted " .. path)
	end
	for _, path in ipairs({ "docs/html/generated.html", ".git/objects/blob", "ignored.txt" }) do
		assert(not found[path], "Search included excluded file " .. path)
	end
end

local pickers = require("telescope.config").pickers
assert_search(pickers.find_files.find_command)
local grep = { "rg", "--files-with-matches", "search-fixture" }
vim.list_extend(grep, pickers.live_grep.additional_args())
assert_search(grep)
vim.fn.delete(root, "rf")
print("Telescope find/grep include source and hidden files, respect exclusions")
