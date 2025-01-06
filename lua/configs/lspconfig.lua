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

local default_servers = { "html", "cssls", "vtsls", "jsonls", "bashls", "volar" }

local nvlsp = require "nvchad.configs.lspconfig"

for _, lsp in ipairs(default_servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

require("lspconfig").jsonls.setup {
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
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = require "configs.lsp.capabilities",
}
require("lspconfig").cssls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = require "configs.lsp.capabilities",
  settings = {
    css = {
      lint = {
        -- Do not warn for Tailwind's @apply rule
        unknownAtRules = "ignore",
      },
    },
  },
}
require("lspconfig").html.setup {
  capabilities = require "configs.lsp.capabilities",
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
}
require("lspconfig").volar.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = require "configs.lsp.capabilities",
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
