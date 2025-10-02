return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
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
      enable = false,
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
    { "nvchad/showkeys", cmd = "ShowkeysToggle", opts = { position = "bottom-right" } },
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
    {
      "karb94/neoscroll.nvim",
      lazy = true,
      opts = {
        hide_cursor = false,
      },
    },
    {
      "sphamba/smear-cursor.nvim",
      opts = {
        stiffness = 0.5,
        trailing_stiffness = 0.5,
        matrix_pixel_threshold = 0.5,
        smear_between_buffers = true,
        smear_between_neighbor_lines = true,
        scroll_buffer_space = true,
        legacy_computing_symbols_support = false,
        smear_insert_mode = true,
      },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        vim.list_extend(opts.ensure_installed, {
          "blade",
          "php_only",
        })
      end,
      config = function(_, opts)
        vim.filetype.add {
          pattern = {
            [".*%.blade%.php"] = "blade",
          },
        }

        require("nvim-treesitter.configs").setup(opts)
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.blade = {
          install_info = {
            url = "https://github.com/EmranMR/tree-sitter-blade",
            files = { "src/parser.c" },
            branch = "main",
          },
          filetype = "blade",
        }
      end,
    },
  },
}
