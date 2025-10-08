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
      ---@type table<string, string>
      includeLanguages = {},
      --- @type string[]
      excludeLanguages = {},
      --- @type string[]
      extensionsPath = {},
      --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
      preferences = {},
      --- @type boolean Defaults to `true`
      showAbbreviationSuggestions = true,
      --- @type "always" | "never" Defaults to `"always"`
      showExpandedAbbreviation = "always",
      --- @type boolean Defaults to `false`
      showSuggestionsAsSnippets = true,
      --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
      syntaxProfiles = {},
      --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
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
