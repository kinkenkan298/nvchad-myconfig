-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "everblush",
  integrations = { "dap" },
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.ui = {
  statusline = {
    separator_style = "round",
    theme = "default",
    enabled = true,
  },
  telescope = {
    style = "borderless",
  },
  tabufline = {
    lazyload = true,
  },
  ident = {
    enable = false,
  },
  hl_override = {
    NvimTreeNormal = { bg = "#141b1e" },
    NvimTreeNormalNC = { bg = "#141b1e" },
    NvimTreeWinSeparator = { bg = "#141b1e", fg = "#141b1e" },
    WinSeparator = { bg = "#141b1e" },
    NavicSeparator = { bg = "#ffffff" },
    BufferLineSeparator = { bg = "#141b1e" },
    WhichKeySeparator = { bg = "#141b1e" },
    BufferLineSeparatorVisible = { bg = "#141b1e" },
    BufferLineSeparatorSelected = { bg = "#141b1e" },
    LineNr = { bg = "#141b1e" },
    NvimTreeOpenedFolderName = { bg = "#141b1e" },
    DapUILineNumber = { bg = "#141b1e" },
    BufferLineBackground = { bg = "#141b1e" },
  },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    "                            ",
    "     ▄▄         ▄ ▄▄▄▄▄▄▄   ",
    "   ▄▀███▄     ▄██ █████▀    ",
    "   ██▄▀███▄   ███           ",
    "   ███  ▀███▄ ███           ",
    "   ███    ▀██ ███           ",
    "   ███      ▀ ███           ",
    "   ▀██ █████▄▀█▀▄██████▄    ",
    "     ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀   ",
    "                            ",
    "     Powered By  eovim    ",
    "                            ",
  },
}

M.ui = {
  statusline = {
    theme = "minimal",
    separator_style = "round",
  },
  cmp = {
    style = "atom",
  },
}

return M
