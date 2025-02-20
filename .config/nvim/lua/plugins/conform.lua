return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>d",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  ---@module "conform"
  ---@type conform.setupOpts
  log_level = vim.log.levels.DEBUG,
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier", "eslint_d", stop_after_first = true },
      typescript = { "prettier", "eslint_d", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      -- typescriptreact = { "biome" },
      javascriptreact = { "prettier", "eslint_d", stop_after_first = true },
      ruby = { "rubocop" },
      eruby = { "erb_format", "htmlbeautifier" },
      zsh = { "shfmt", "shellcheck" },
      bash = { "shfmt", "shellcheck" },
      sh = { "shfmt", "shellcheck" },
      css = { "prettierd" },
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
      -- erblint = {
      --   command = "bundle",
      --   args = function(self, ctx)
      --     return {
      --       "exec",
      --       "erb_lint",
      --       "--autocorrect",
      --       ctx.filename
      --     }
      --   end,
      --   stdin = false,
      --   -- cwd = require("conform.util").root_file({ "Gemfile" }),
      --   require_cwd = true,
      -- }
    },
    format_on_save = {
      timeout_ms = 5000,
      lsp_format = "fallback",
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
