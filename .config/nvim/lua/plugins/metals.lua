return {
  "scalameta/nvim-metals",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ft = { "scala", "sbt", "java" },
  opts = function()
    local metals = require("metals")

    -- metals.setup_dap()

    local metals_config = metals.bare_config()
    -- "off" will enable LSP progress notifications by Metals and you'll need
    -- to ensure you have a plugin like fidget.nvim installed to handle them.
    --
    -- "on" will enable the custom Metals status extension and you *have* to have
    -- a have settings to capture this in your statusline or else you'll not see
    -- any messages from metals. There is more info in the help docs about this
    metals_config.init_options.statusBarProvider = "off"
    metals_config.settings = {
      showImplicitArguments = true,
      showImplicitConversionsAndClasses = true,
      showInferredType = true,
    }

    metals_config.root_patterns = { "build.sbt", "build.sc", "build.gradle", "pom.xml" }

    metals_config.capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )
    metals_config.on_attach = function(_client, bufnr)
      vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, {
        buffer = bufnr,
        desc = "LSP: [C]ode [L]ens Run",
      })

      vim.keymap.set("n", "<leader>ws", function()
        require("metals").hover_worksheet()
      end, { buffer = bufnr, desc = "LSP: [W]ork[S]heet Hover" })

      vim.keymap.set(
        "n",
        "<leader>oi",
        ":MetalsOrganizeImports<cr>",
        { buffer = bufnr, desc = "LSP: [O]rganize [I]mports" }
      )
    end

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}
