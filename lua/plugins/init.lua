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
      enabled = false,
    },

    {
      "wakatime/vim-wakatime",
      lazy = false,
    },

    { "nvzone/volt", lazy = true },

    {
      "nvzone/minty",
      lazy = true,
      config = function()
        require "configs.minty"
      end,
    },

    { "nvzone/menu", lazy = true },

    { "nvzone/showkeys", cmd = "ShowkeysToggle", opts = { position = "bottom-right" } },

    { "nvzone/timerly", cmd = "TimerlyToggle" },

    { import = "nvchad.blink.lazyspec" },
  },
}
