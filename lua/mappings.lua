require "nvchad.mappings"

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

for _, mode in ipairs { "i", "v", "n", "x" } do
  map(mode, "<S-Down>", "<cmd>t.<cr>", opts)
  map(mode, "<S-Up>", "<cmd>t -1<cr>", opts)
  map(mode, "<C-s>", "<cmd>silent! w<cr>", opts)
end

map("x", "<S-Down>", ":'<,'>t'><cr>", opts)

map("x", "<A-Down>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-Up>", ":move '<-2<CR>gv-gv", opts)
map("n", "<M-Down>", "<cmd>m+<cr>", opts)
map("i", "<M-Down>", "<cmd>m+<cr>", opts)
map("n", "<M-Up>", "<cmd>m-2<cr>", opts)
map("i", "<M-Up>", "<cmd>m-2<cr>", opts)

map("n", "q", "<cmd>q<cr>", opts)
map({ "n", "i" }, "<leader>q", "<cmd>q<cr>", opts)

map("n", "<C-t>", function()
  require("nvchad.themes").open {
    style = "compact",
  }
end, opts)

map("n", "<leader><space>", function()
  require("snacks").picker.smart()
end)

map("n", "<leader>e", function()
  require("snacks").explorer {
    git_status = true,
    git_status_open = true,
    git_untracked = true,
    env = { env = ".env" },
    hidden = true,
    auto_close = false,
    layout = { preset = "sidebar", preview = false, layout = { position = "left" } },
  }
end)
