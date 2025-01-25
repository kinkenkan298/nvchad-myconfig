local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

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
    opts_extend = { "sources.default", "sources.cmdline" },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-N>"] = { "select_next", "show" },
        ["<C-P>"] = { "select_prev", "show" },
        ["<C-J>"] = { "select_next", "fallback" },
        ["<C-K>"] = { "select_prev", "fallback" },
        ["<C-U>"] = { "scroll_documentation_up", "fallback" },
        ["<C-D>"] = { "scroll_documentation_down", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = {
          "select_next",
          "snippet_forward",
          function(cmp)
            if has_words_before() then
              return cmp.show()
            end
          end,
          "fallback",
        },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },

      sources = {
        default = { "lsp", "path", "buffer", "snippets" },
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
          range = "prefix",
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
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
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
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
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
  {
    "xzbdmw/colorful-menu.nvim",
    config = function()
      require("colorful-menu").setup {
        ls = {
          lua_ls = {
            arguments_hl = "@comment",
          },
          ts_ls = {
            extra_info_hl = "@comment",
          },
          vtsls = {
            extra_info_hl = "@comment",
          },
          ["rust-analyzer"] = {
            extra_info_hl = "@comment",
          },
          clangd = {
            extra_info_hl = "@comment",
          },
          roslyn = {
            extra_info_hl = "@comment",
          },
          basedpyright = {
            extra_info_hl = "@comment",
          },
          fallback = true,
        },
        fallback_highlight = "@variable",
        max_width = 80,
      }
    end,
  },
}
