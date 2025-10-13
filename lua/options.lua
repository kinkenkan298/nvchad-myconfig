require "nvchad.options"

local M = {}

local o = vim.o

o.number = true
o.relativenumber = true
o.signcolumn = "yes"
o.wrap = false
o.cursorlineopt = "both" -- to enable cursorline!
o.ignorecase = true
o.background = "dark"

o.formatexpr = "v:lua.require'conform'.formatexpr()" -- auto format

vim.opt.mouse = "a"
vim.opt.cmdheight = 0

vim.opt.showmode = false

if vim.fn.has "nvim-0.10" == 1 then
  vim.opt.smoothscroll = true
end
