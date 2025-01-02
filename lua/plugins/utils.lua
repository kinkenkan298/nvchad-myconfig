return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require "configs.inline-diagnostic"
    end,
  },
  {
    "IogaMaster/neocord",
    event = "VeryLazy",
    config = function()
      require "configs.neocord"
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.hlchunk"
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    version = false,
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
    specs = {
      {
        "windwp/nvim-autopairs",
        enabled = false,
      },
    },
  },
}
