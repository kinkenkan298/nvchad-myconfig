local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

---@type function?
local icon_provider

local function get_icon(CTX)
  if not icon_provider then
    local base = function(ctx)
      ctx.kind_hl_group = "BlinkCmpKind" .. ctx.kind
    end
    local _, mini_icons = pcall(require, "mini.icons")
    if _G.MiniIcons then
      icon_provider = function(ctx)
        base(ctx)
        if ctx.item.source_name == "LSP" then
          local item_doc, color_item = ctx.item.documentation, nil
          if item_doc then
            local highlight_colors_avail, highlight_colors = pcall(require, "nvim-highlight-colors")
            color_item = highlight_colors_avail and highlight_colors.format(item_doc, { kind = ctx.kind })
          end
          local icon, hl = mini_icons.get("lsp", ctx.kind or "")
          if icon then
            ctx.kind_icon = icon
            ctx.kind_hl_group = hl
          end
          if color_item and color_item.abbr and color_item.abbr_hl_group then
            ctx.kind_icon, ctx.kind_hl_group = color_item.abbr, color_item.abbr_hl_group
          end
        elseif ctx.item.source_name == "Path" then
          ctx.kind_icon, ctx.kind_hl_group = mini_icons.get(ctx.kind == "Folder" and "directory" or "file", ctx.label)
        end
      end
    end
    local lspkind_avail, lspkind = pcall(require, "lspkind")
    if lspkind_avail then
      icon_provider = function(ctx)
        base(ctx)
        if ctx.item.source_name == "LSP" then
          local item_doc, color_item = ctx.item.documentation, nil
          if item_doc then
            local highlight_colors_avail, highlight_colors = pcall(require, "nvim-highlight-colors")
            color_item = highlight_colors_avail and highlight_colors.format(item_doc, { kind = ctx.kind })
          end
          local icon = lspkind.symbolic(ctx.kind, { mode = "symbol" })
          if icon then
            ctx.kind_icon = icon
          end
          if color_item and color_item.abbr and color_item.abbr_hl_group then
            ctx.kind_icon, ctx.kind_hl_group = color_item.abbr, color_item.abbr_hl_group
          end
        end
      end
    end
    icon_provider = base
  end
  icon_provider(CTX)
end

local function cmpBorder(hl_name)
  return {
    -- just the enought chars to show the scrollbar correctly
    { "╭", hl_name }, -- top left
    { "─", hl_name }, -- top
    { "╮", hl_name }, -- top right
    { "│", hl_name }, -- right
    { "╯", hl_name }, -- bottom right
    { "─", hl_name }, -- bottom
    { "╰", hl_name }, -- bottom left
    { "│", hl_name }, -- left
  }
end

return {
  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter", "VeryLazy" },
    version = "0.*",
    dependencies = {
      {
        "saghen/blink.compat",
        opts = {},
      },
      {
        "rafamadriz/friendly-snippets",
        optional = true,
      },
      "dmitmel/cmp-cmdline-history",
    },
    opts_extend = { "sources.default", "sources.cmdline" },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = {
        preset = "luasnip",
      },
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
          snippets = {
            max_items = 10,
          },
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
              return ctx.mode ~= "cmdline" and not require("blink.cmp").snippet_active { direction = 1 }
            end,
          },
        },
        menu = {
          border = "solid",
          scrollbar = false,
          winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
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
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
            treesitter = { "lsp" },
          },
        },
        accept = {
          auto_brackets = { enabled = true },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = cmpBorder "BlinkCmpDocBorder",
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
        "neovim/nvim-lspconfig",
        optional = true,
        dependencies = { "saghen/blink.cmp" },
      },
      {
        "folke/lazydev.nvim",
        optional = true,
        specs = {
          { -- optional blink completion source for require statements and module annotations
            "saghen/blink.cmp",
            opts = {
              sources = {
                -- add lazydev to your completion providers
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                  lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
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
      -- { "L3MON4D3/LuaSnip", enabled = false },
    },
  },
}
