require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- MODES
-- mormal mode = "n"
-- insert mode = "i"
-- visual mode = "v"
-- visual block mode = "x"
-- term mode = "t"
-- command mode = "c"

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

for _, mode in ipairs { "i", "v", "n", "x" } do
  -- duplicate line
  map(mode, "<S-Down>", "<cmd>t.<cr>", opts)
  map(mode, "<S-Up>", "<cmd>t -1<cr>", opts)
  -- save file
  map(mode, "<C-s>", "<cmd>silent! w<cr>", opts)
end
-- duplicate line visual block
map("x", "<S-Down>", ":'<,'>t'><cr>", opts)
-- move text up and down
map("x", "<A-Down>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-Up>", ":move '<-2<CR>gv-gv", opts)
map("n", "<M-Down>", "<cmd>m+<cr>", opts)
map("i", "<M-Down>", "<cmd>m+<cr>", opts)
map("n", "<M-Up>", "<cmd>m-2<cr>", opts)
map("i", "<M-Up>", "<cmd>m-2<cr>", opts)

-- close windows
map("n", "q", "<cmd>q<cr>", opts)
map({ "n", "i" }, "<leader>q", "<cmd>q<cr>", opts)

map("n", "<C-t>", function()
  require("snacks").picker.colorschemes()
end, opts)

map("n", "<leader><space>", function()
  require("snacks").picker.smart()
end)
map("n", "<leader>,", function()
  require("snacks").picker.buffers()
end)
map("n", "<leader>n", function()
  require("snacks").picker.notifications()
end)
map("n", "<leader>e", function()
  require("snacks").explorer()
end)
map("n", "<leader>:", function()
  require("snacks").picker.command_history()
end, opts)
map("n", "<leader>ff", function()
  require("snacks").picker.files()
end, opts)
map("n", "<leader>fc", function()
  require("snacks").picker.config()
end, opts)
map("n", "<leader>fg", function()
  require("snacks").picker.git_files()
end, opts)
map("n", "<leader>fr", function()
  require("snacks").picker.recent()
end, opts)
map("n", "<leader>fp", function()
  require("snacks").picker.projects()
end, opts)
