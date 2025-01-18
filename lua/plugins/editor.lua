return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    enabled = true,
    config = function(_, opts)
      if opts[1] == "default-title" then
        local function fix(t)
          t.prompt = t.prompt ~= nil and " " or nil
          for _, v in pairs(t) do
            if type(v) == "table" then
              fix(v)
            end
          end
          return t
        end
        opts = vim.tbl_deep_extend("force", fix(require "fzf-lua.profiles.default-title"), opts)
        opts[1] = nil
      end
      require("fzf-lua").setup(opts)
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      preset = "helix",
      default = {},
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>c", group = "code" },
          { "<leader>d", group = "debug" },
          { "<leader>dp", group = "profiler" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>w", group = "workspace", icon = { icon = "󰙵 ", color = "cyan" } },
          { "gs", group = "surround" },
          { "z", group = "fold" },
        },
      },
    },
    config = function(_, opts)
      local wk = require "which-key"
      wk.setup(opts)
    end,
  },
  {
    "eldritch-theme/eldritch.nvim",
    lazy = true,
  },
}
