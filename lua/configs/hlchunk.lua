local options = {
  chunk = {
    enable = true,
  },
  indent = {
    enable = true,
    chars = {
      "│",
      "¦",
      "┆",
      "┊",
    },
    style = {
      vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID "Whitespace"), "fg", "gui"),
    },
  },
  line_num = {
    enable = true,
    style = "#806d9c",
  },
}
require("hlchunk").setup(options)
