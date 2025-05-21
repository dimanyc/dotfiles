return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- Load colorscheme before other plugins
    config = function()
      require("gruvbox").setup({
        -- Configure gruvbox options here. Some useful ones:
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "",  -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {
          SignColumn = { bg = "NONE" }, -- This will match signcolumn to background
        },
        dim_inactive = false,
        transparent_mode = false,
      })

      -- Set colorscheme after options
      vim.cmd("colorscheme gruvbox")
    end,
  }
}
