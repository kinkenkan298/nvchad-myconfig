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
-- create comment CTRL + / all mode
map("v", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
map("v", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
map("i", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
map("i", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opts)
map("i", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)
map("i", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)
map("n", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)
map("n", "<C-/>", "<esc><cmd>lua require('Comment.api').toggle.linewise.current()<cr>", opts)

-- close windows
-- map("n", "q", "<cmd>q<cr>", opts)
map({ "n", "i" }, "<leader>q", "<cmd>q<cr>", opts)

map("n", "<C-t>", function()
  require("nvchad.themes").open {
    style = "compact",
  }
end, opts)

-- mappings fzf
map("n", "<leader>ff", function()
  require("fzf-lua").files()
end, { silent = true, noremap = true, desc = "FZF find files" })
map("n", "<leader>fw", function()
  require("fzf-lua").live_grep_native()
end, { silent = true, noremap = true, desc = "FZF find Words" })

-- mappings fzf git
if vim.fn.executable "git" == 1 then
  map("n", "<leader>gb", function()
    require("fzf-lua").git_branches()
  end, { silent = true, noremap = true, desc = "FZF find git branches" })
  map("n", "<leader>gc", function()
    require("fzf-lua").git_commits()
  end, { silent = true, noremap = true, desc = "FZF find git commit" })
  map("n", "<leader>gC", function()
    require("fzf-lua").git_bcommits()
  end, { silent = true, noremap = true, desc = "FZF find git commit (current file)" })
  map("n", "<leader>gt", function()
    require("fzf-lua").git_status()
  end, { silent = true, noremap = true, desc = "FZF find git status" })
end
