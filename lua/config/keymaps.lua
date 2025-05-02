-- lua/config/keymaps.lua

-- Utility function for mapping keys
local map = function(mode, keys, command, desc)
	vim.keymap.set(mode, keys, command, { noremap = true, silent = true, desc = desc })
end

-- Leader shortcuts (`,` is leader as set above)
-- (Additional leader mappings can be added here if needed)

-- Normal mode mappings
map("n", "<Space>", "zz", "Center screen on cursor") -- Press Space to center the screen at the cursor line
map("n", "<C-x>", ":bnext<CR>", "Next buffer") -- Ctrl-X: switch to next buffer
map("n", "<C-z>", ":bprevious<CR>", "Previous buffer") -- Ctrl-Z: switch to previous buffer (repurposed, was suspend)
map("n", "<C-a>", "<cmd>NvimTreeToggle<CR>", "Toggle file tree") -- Ctrl-A: open/close file explorer sidebar
map("n", "<C-r>", "<cmd>NvimTreeRefresh<CR>", "Refresh file tree") -- Ctrl-R: refresh file explorer (e.g., after changes)

-- Multiple cursors (vim-visual-multi) will use <C-n> by default:
-- In normal mode <C-n> starts adding a cursor at current word, in visual it adds another selection.
-- We ensure <C-n> is not mapped to anything else, so no explicit mapping needed here (plugin handles it).

-- Telescope find/grep mappings (these will trigger lazy-loading of Telescope)
-- (Defined in plugin config via lazy keys, see plugins.lua)

-- Other convenient mappings
map("n", "Y", "y$", "Yank to end of line (like D/C)") -- Make Y act like D (delete) and C (change)
map("n", "n", "nzzzv", "Next search result centered") -- After search, center next match
map("n", "N", "Nzzzv", "Previous search result centered") -- Center the screen on previous match
map("n", "J", "mzJ`z", "Join lines without moving cursor") -- Join lines and keep cursor in place
map("i", "jk", "<Esc>", "Exit insert mode quickly") -- Press 'jk' fast in insert mode to exit to normal

-- Save and quit shortcuts
map("n", "<Leader>w", ":w<CR>", "Save file")
map("n", "<Leader>q", ":q<CR>", "Quit")

local map = vim.keymap.set
map({ "n", "t" }, "<C-t>", "<cmd>Lspsaga term_toggle<CR>", { desc = "Toggle float term", silent = true })
