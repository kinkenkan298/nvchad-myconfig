return {
  {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "vue" },
    config = function()
      require "configs.lsp.typescript_ls"
    end,
  },
  {
    "folke/neodev.nvim",
    ft = "lua",
    config = function()
      require("neodev").setup()
      require "configs.lsp.lua_ls"
    end,
  },
}
