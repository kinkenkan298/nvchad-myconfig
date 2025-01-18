local options = {
  chunk = {
    priority = 15,
    style = {
      { fg = "#806d9c" },
      { fg = "#c21f30" },
    },
    use_treesitter = true,
    chars = {
      horizontal_line = "─",
      vertical_line = "│",
      left_top = "╭",
      left_bottom = "╰",
      right_arrow = ">",
    },
    textobject = "",
    max_file_size = 1024 * 1024,
    error_sign = true,
    -- animation related
    duration = 300,
    delay = 300,
    enable = true,
  },
  indent = {
    enable = true,
    use_treesitter = true,
    chars = { "│" },
    style = { vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID "Whitespace"), "fg", "gui") },
  },
  line_num = { enable = true, style = "#806d9c", use_treesitter = true },
}
require("hlchunk").setup(options)
