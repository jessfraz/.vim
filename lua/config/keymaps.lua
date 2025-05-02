-- lua/config/keymaps.lua

-- Utility function for mapping keys
local map = function(mode, keys, command, desc)
  vim.keymap.set(mode, keys, command, { noremap = true, silent = true, desc = desc })
end

-- Leader shortcuts (`,` is leader as set above)
-- (Additional leader mappings can be added here if needed)

-- Normal mode mappings
map("n", "<Space>", "zz", "Center screen on cursor")         -- Press Space to center the screen at the cursor line:contentReference[oaicite:2]{index=2}
map("n", "<C-x>", ":bnext<CR>", "Next buffer")               -- Ctrl-X: switch to next buffer:contentReference[oaicite:3]{index=3}
map("n", "<C-z>", ":bprevious<CR>", "Previous buffer")       -- Ctrl-Z: switch to previous buffer (repurposed, was suspend):contentReference[oaicite:4]{index=4}
map("n", "<C-t>", "<cmd>Lspsaga open_floaterm<CR>", "Toggle floating terminal")  -- Ctrl-T: open a floating terminal (via LspSaga):contentReference[oaicite:5]{index=5}
map("t", "<C-t>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], "Close floating terminal")  -- Ctrl-T: in terminal mode, close it:contentReference[oaicite:6]{index=6}
map("n", "<C-a>", "<cmd>NvimTreeToggle<CR>", "Toggle file tree")   -- Ctrl-A: open/close file explorer sidebar:contentReference[oaicite:7]{index=7}
map("n", "<C-r>", "<cmd>NvimTreeRefresh<CR>", "Refresh file tree") -- Ctrl-R: refresh file explorer (e.g., after changes):contentReference[oaicite:8]{index=8}

-- Multiple cursors (vim-visual-multi) will use <C-n> by default:
-- In normal mode <C-n> starts adding a cursor at current word, in visual it adds another selection.
-- We ensure <C-n> is not mapped to anything else, so no explicit mapping needed here (plugin handles it).

-- Telescope find/grep mappings (these will trigger lazy-loading of Telescope)
-- (Defined in plugin config via lazy keys, see plugins.lua)

-- Other convenient mappings
map("n", "Y", "y$", "Yank to end of line (like D/C)")        -- Make Y act like D (delete) and C (change)
map("n", "n", "nzzzv", "Next search result centered")        -- After search, center next match
map("n", "N", "Nzzzv", "Previous search result centered")    -- Center the screen on previous match
map("n", "J", "mzJ`z", "Join lines without moving cursor")   -- Join lines and keep cursor in place
map("i", "jk", "<Esc>", "Exit insert mode quickly")          -- Press 'jk' fast in insert mode to exit to normal

-- Save and quit shortcuts
map("n", "<Leader>w", ":w<CR>", "Save file")
map("n", "<Leader>q", ":q<CR>", "Quit")

