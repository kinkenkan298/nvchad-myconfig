return {
  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    version = "0.*",
    dependencies = {
      "saghen/blink.compat",
      "rafamadriz/friendly-snippets",
      "dmitmel/cmp-cmdline-history",
      "xzbdmw/colorful-menu.nvim",
    },
    opts_extend = {
      "sources.default",
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
            preselect = true,
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
          auto_show_delay_ms = 0,
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
