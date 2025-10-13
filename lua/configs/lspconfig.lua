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
        includePaths = { "vendor" },
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
      "php",
    },
    init_options = {
      includeLanguages = {},
      excludeLanguages = {},
      extensionsPath = {},
      preferences = {},
      showAbbreviationSuggestions = true,
      showExpandedAbbreviation = "always",
      showSuggestionsAsSnippets = true,
      syntaxProfiles = {},
      variables = {},
    },
  },
  pyright = {},
  clangd = {},
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
