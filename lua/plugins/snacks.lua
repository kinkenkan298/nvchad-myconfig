return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        if event.data.actions.type == "move" then
          Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
        end
      end,
    })
  end,
  keys = {
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Buffer delete",
      mode = "n",
    },
    {
      "<leader>ba",
      function()
        Snacks.bufdelete.all()
      end,
      desc = "Buffer delete all",
      mode = "n",
    },
    {
      "<leader>bo",
      function()
        Snacks.bufdelete.other()
      end,
      desc = "Buffer delete other",
      mode = "n",
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
  },
  ---@class snacks.Config
  ---@field animate? snacks.animate.Config
  ---@field bigfile? snacks.bigfile.Config
  ---@field dashboard? snacks.dashboard.Config
  ---@field dim? snacks.dim.Config
  ---@field explorer? snacks.explorer.Config
  ---@field gitbrowse? snacks.gitbrowse.Config
  ---@field image? snacks.image.Config
  ---@field indent? snacks.indent.Config
  ---@field input? snacks.input.Config
  ---@field layout? snacks.layout.Config
  ---@field lazygit? snacks.lazygit.Config
  ---@field notifier? snacks.notifier.Config
  ---@field picker? snacks.picker.Config
  ---@field profiler? snacks.profiler.Config
  ---@field quickfile? snacks.quickfile.Config
  ---@field scope? snacks.scope.Config
  ---@field scratch? snacks.scratch.Config
  ---@field scroll? snacks.scroll.Config
  ---@field statuscolumn? snacks.statuscolumn.Config
  ---@field terminal? snacks.terminal.Config
  ---@field toggle? snacks.toggle.Config
  ---@field win? snacks.win.Config
  ---@field words? snacks.words.Config
  ---@field zen? snacks.zen.Config
  ---@field styles? table<string, snacks.win.Config>
  ---@field image? snacks.image.Config|{}
  opts = {
    bigfile = {
      enabled = true,
    },
    dashboard = { enabled = false },
    explorer = {
      enabled = true,
    },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
}
