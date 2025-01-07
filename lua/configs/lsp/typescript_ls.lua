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
