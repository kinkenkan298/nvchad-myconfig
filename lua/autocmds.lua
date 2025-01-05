local autocmd = vim.api.nvim_create_autocmd

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
vim.opt.guicursor = {
  "n-v:block", -- Normal, Visual, Command mode: block cursor
  "i-ci-ve-c:ver25", -- Insert, Command-line Insert, Visual mode: vertical bar cursor
  "r-cr:hor20", -- Replace, Command-line Replace mode: horizontal bar cursor
  "o:hor50", -- Operator-pending mode: horizontal bar cursor
  "a:blinkwait700-blinkoff400-blinkon250", -- Blinking settings
  "sm:block-blinkwait175-blinkoff150-blinkon175", -- Select mode: block cursor with blinking
}
