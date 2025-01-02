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
  },
}
