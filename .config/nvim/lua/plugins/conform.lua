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
      javascriptreact = { "prettier", "eslint_d", stop_after_first = true },
      ruby = { "rubocop" },
      eruby = { "erb_format" },
      zsh = { "shfmt", "shellcheck" },
      bash = { "shfmt", "shellcheck" },
      sh = { "shfmt", "shellcheck" },
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
