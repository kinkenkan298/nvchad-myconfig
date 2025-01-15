local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})
autocmd("InsertEnter", {
  pattern = "*",
  command = "set nopaste",
})
autocmd("FileType", {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})
-- autocmd("User", {
--   pattern = "BlinkCmpMenuOpen",
--   callback = function()
--     require("copilot.suggestion").dismiss()
--     vim.b.copilot_suggestion_hidden = true
--   end,
-- })
--
-- autocmd("User", {
--   pattern = "BlinkCmpMenuClose",
--   callback = function()
--     vim.b.copilot_suggestion_hidden = false
--   end,
-- })

autocmd("User", {
  group = augroup "load_clipboard",
  pattern = "VeryLazy",
  callback = function()
    vim.opt.clipboard = "unnamedplus"
  end,
})

autocmd("BufReadPost", {
  group = augroup "last_loc",
  callback = function()
    local exclude = { "gitcommit", "gitrebase", "Trouble" }
    local buf = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
      vim.api.nvim_command "normal! zz"
    end
  end,
})

autocmd("FileType", {
  group = augroup "nvr_as_git_editor",
  pattern = {
    "gitcommit",
    "gitrebase",
    "gitconfig",
  },
  callback = function(event)
    vim.bo[event.buf].bufhidden = "wipe"
  end,
})
