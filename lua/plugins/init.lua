return {
  {
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    {
      "stevearc/conform.nvim",
      event = "BufWritePre", -- uncomment for format on save
      opts = require "configs.conform",
    },
    {
      "nvim-treesitter/nvim-treesitter",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require "configs.treesitter"
      end,
    },
    {
      "nvim-tree/nvim-tree.lua",
      lazy = true,
      keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "󰙅 Explorer" },
        { "<leader>o", "<cmd>NvimTreeFocus<cr>", desc = "󰙅  Explorer (Focus)" },
      },
    },
    {
      "shellRaining/hlchunk.nvim",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require "configs.hlchunk"
      end,
    },
    { "nvchad/volt", lazy = true },
    {
      "nvchad/minty",
      lazy = true,
      config = function()
        require "configs.minty"
      end,
    },
    { "nvchad/menu", lazy = true },
    { "nvchad/showkeys", cmd = "ShowkeysToggle", opts = { position = "top-center" } },
    { "nvchad/timerly", cmd = "TimerlyToggle" },
    {
      "rachartier/tiny-inline-diagnostic.nvim",
      event = "VeryLazy",
      priority = 1000,
      config = function()
        require "configs.inline-diagnostic"
        vim.diagnostic.config { virtual_text = false } -- Disable default virtual text
      end,
    },
    { import = "nvchad.blink.lazyspec" },
  },
}
