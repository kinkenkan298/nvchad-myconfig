return {
  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter", "VeryLazy" },
    version = "0.*",
    dependencies = {
      "saghen/blink.compat",
      "rafamadriz/friendly-snippets",
      "dmitmel/cmp-cmdline-history",
      "xzbdmw/colorful-menu.nvim",
    },
    opts_extend = {
      "sources.default",
      "sources.cmdline",
      "sources.completion.enabled_providers",
      "sources.compat",
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "enter",
      },

      sources = {
        compat = {},
        default = { "lsp", "path", "snippets", "buffer" },
        cmdline = function()
          local type = vim.fn.getcmdtype()
          -- Search forward and backward
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          -- Commands
          if type == ":" or type == "@" then
            return { "cmdline_history", "cmdline" }
          end
          return {}
        end,
        providers = {
          buffer = {
            max_items = 10,
            score_offset = -1,
          },
          path = {
            max_items = 10,
          },
          cmdline = {
            max_items = 10,
          },
          cmdline_history = {
            name = "cmdline_history",
            module = "blink.compat.source",
          },
        },
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },
      completion = {
        ghost_text = {
          enabled = true,
        },
        keyword = {
          range = "full",
        },
        list = {
          selection = {
            auto_insert = false,
            preselect = function(ctx)
              return ctx.mode ~= "cmdline"
            end,
          },
        },
        menu = {
          auto_show = true,
          border = "rounded",
          scrollbar = false,
          -- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          draw = {
            padding = 2,
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return kind_icon
                end,
                -- Optionally, you may also use the highlights from mini.icons
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
            },
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            treesitter = { "lsp" },
          },
        },
        accept = {
          auto_brackets = { enabled = true },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 300,
          window = {
            border = "rounded",
            winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:PmenuSel,EndOfBuffer:BlinkCmpDoc,Search:None",
          },
        },
      },
      signature = {
        enabled = false,
      },
    },
    ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
    config = function(_, opts)
      local enabled = opts.sources.default
      for _, source in ipairs(opts.sources.compat or {}) do
        opts.sources.providers[source] = vim.tbl_deep_extend(
          "force",
          { name = source, module = "blink.compat.source" },
          opts.sources.providers[source] or {}
        )
        if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
          table.insert(enabled, source)
        end
      end
      -- Unset custom prop to pass blink.cmp validation
      opts.sources.compat = nil

      -- check if we need to override symbol kinds
      for _, provider in pairs(opts.sources.providers or {}) do
        ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
        if provider.kind then
          local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
          local kind_idx = #CompletionItemKind + 1

          CompletionItemKind[kind_idx] = provider.kind
          ---@diagnostic disable-next-line: no-unknown
          CompletionItemKind[provider.kind] = kind_idx

          ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
          local transform_items = provider.transform_items
          ---@param ctx blink.cmp.Context
          ---@param items blink.cmp.CompletionItem[]
          provider.transform_items = function(ctx, items)
            items = transform_items and transform_items(ctx, items) or items
            for _, item in ipairs(items) do
              item.kind = kind_idx or item.kind
            end
            return items
          end
          -- Unset custom prop to pass blink.cmp validation
          provider.kind = nil
        end
      end
      require("blink.cmp").setup(opts)
    end,
    specs = {
      {
        "L3MON4D3/LuaSnip",
        optional = true,
        specs = { { "Saghen/blink.cmp", opts = { snippets = { preset = "luasnip" } } } },
      },
      {
        "neovim/nvim-lspconfig",
        optional = true,
        dependencies = { "saghen/blink.cmp" },
      },
      {
        "folke/lazydev.nvim",
        optional = true,
        specs = {
          {
            "saghen/blink.cmp",
            opts = {
              sources = {
                default = { "lazydev" },
                providers = {
                  lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                  },
                },
              },
            },
          },
        },
      },

      { "hrsh7th/nvim-cmp", enabled = false },
      { "rcarriga/cmp-dap", enabled = false },
    },
  },
}
