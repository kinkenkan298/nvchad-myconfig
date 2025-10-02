require("nvchad.configs.lspconfig").defaults()

local servers = {
  html = {},
  cssls = {},
  vtsls = {},
  intelephense = {
    root_markers = { "index.php", ".git", "composer.json" },
    settings = {
      files = {
        associations = { "*.php" },
        maxSize = 1000000,
      },
      environment = {
        includePaths = { "./", "vendor" }, -- biar auto import jalan ke vendor/ juga
      },
    },
  },
  ts_ls = {},
  emmet_language_server = {
    filetypes = {
      "astro",
      "css",
      "eruby",
      "html",
      "htmlangular",
      "htmldjango",
      "javascriptreact",
      "less",
      "pug",
      "sass",
      "scss",
      "svelte",
      "templ",
      "typescriptreact",
      "vue",
    },
  },
  pyright = {},
  clangd = {},
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
