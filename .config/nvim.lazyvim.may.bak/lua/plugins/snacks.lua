return {
  -- change trouble config
  {
    "folke/snacks.nvim",
    -- opts will be merged with the parent spec
    dependencies = { "folke/noice.nvim" },
    opts = {
      explorer = { enabled = false },
      indent = {
        enabled = true,
        animate = {
          duration = 0,
        },
      },
      statuscolumn = {
        git = {
          patterns = { "GitSign", "MiniDiffSign" },
        },
      },
    },
  },
}
