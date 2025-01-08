require "nvchad.options"

local o = vim.o

o.number = true
o.relativenumber = true
o.signcolumn = "yes"
o.wrap = false
o.cursorlineopt = "both" -- to enable cursorline!
o.ignorecase = true

vim.opt.mouse = "a"
vim.opt.cmdheight = 0

vim.opt.showmode = false

if vim.fn.has "nvim-0.10" == 1 then
  vim.opt.smoothscroll = true
end
