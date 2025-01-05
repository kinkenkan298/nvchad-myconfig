return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "petertriho/cmp-git",
    },
    opts = function()
      dofile(vim.g.base46_cache .. "cmp")
      local cmp = require "cmp"
      local options = {
        completion = { completeopt = "menu,menuone" },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),

          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources({
          { name = "git" },
          { name = "nvim_lsp" },
        }, {
          { name = "luasnip" },
        }, {
          { name = "cmp-path" },
          { name = "buffer", keyword_length = 5 },
        }),
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      }
      return vim.tbl_deep_extend("force", options, require "nvchad.cmp")
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    lazy = true,
    event = "InsertEnter",
    opts = {},
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        opts = {
          suggestion = { enabled = false },
          panel = { enabled = false },
        },
      },
    },
    specs = {
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = { suggestion = { auto_trigger = true, debounce = 150 } },
      },
      {
        "hrsh7th/nvim-cmp",
        optional = true,
        dependencies = { "zbirenbaum/copilot-cmp" },
        opts = function(_, opts)
          -- Inject copilot into cmp sources, with high priority
          table.insert(opts.sources, 1, {
            name = "copilot",
            group_index = 1,
            priority = 10000,
          })
        end,
      },
      {
        "onsails/lspkind.nvim",
        optional = true,
        -- Adds icon for copilot using lspkind
        opts = function(_, opts)
          opts.symbol_map.Copilot = ""
        end,
      },
    },
    enabled = false,
  },
}
