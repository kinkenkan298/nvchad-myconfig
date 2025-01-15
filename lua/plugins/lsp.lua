return {
  {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "typescriptreact", "javascript", "vue" },
    config = function()
      require("typescript-tools").setup {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
        },
        settings = {
          tsserver_plugins = {
            "@vue/typescript-plugin",
          },
        },
        capabilities = require("blink-cmp").get_lsp_capabilities(),
      }
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
