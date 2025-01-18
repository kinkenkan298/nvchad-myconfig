require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
lspconfig.servers = {
  "bashls",
  "cssls",
  "html",
  "jsonls",
  "vtsls",
  "volar",
}
local default_servers = { "html", "cssls", "vtsls", "jsonls", "bashls", "volar", "yamlls", "tailwindcss" }
local nvlsp = require "nvchad.configs.lspconfig"

for _, lsp in ipairs(default_servers) do
  lspconfig[lsp].setup {
    on_attach = function(client, buffnr)
      nvlsp.on_attach(client, buffnr)
      require("inlay-hints").on_attach(client, buffnr)
    end,
    on_init = nvlsp.on_init,
    -- capabilities = require("blink.cmp").get_lsp_capabilities(nvlsp.capabilities),
    capabilities = nvlsp.capabilities,
  }
end

lspconfig["jsonls"].setup {
  settings = {
    json = {
      schemas = {
        { fileMatch = { "jsconfig.json" }, url = "https://json.schemastore.org/jsconfig" },
        { fileMatch = { "tsconfig.json" }, url = "https://json.schemastore.org/tsconfig" },
        { fileMatch = { "package.json" }, url = "https://json.schemastore.org/package" },
        {
          fileMatch = { ".prettierrc.json", ".prettierrc" },
          url = "https://json.schemastore.org/prettierrc.json",
        },
        { fileMatch = { ".eslintrc.json" }, url = "https://json.schemastore.org/eslintrc.json" },
      },
    },
  },
}
lspconfig["cssls"].setup {
  settings = {
    css = {
      lint = {
        -- Do not warn for Tailwind's @apply rule
        unknownAtRules = "ignore",
      },
    },
  },
}
lspconfig["volar"].setup {
  filetypes = { "vue" },
  settings = {
    vue = {
      complete = {
        casing = {
          props = "autoCamel",
        },
      },
    },
  },
}
