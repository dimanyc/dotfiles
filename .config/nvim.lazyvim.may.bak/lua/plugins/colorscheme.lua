return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      bold = false,
      italic = {
        strings = false,
        emphasis = false,
        comments = false,
        folds = true,
        operators = false,
      },
      contrast = "soft",
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      lazy = false,
      priority = 1000,
      colorscheme = "gruvbox",
    },
  },
}
