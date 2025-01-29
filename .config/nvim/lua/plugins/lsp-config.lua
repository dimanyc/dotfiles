return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local mason_lspconfig = require("mason-lspconfig")

      -- Server configurations
      local servers = {
        solargraph = {},
        -- ruby_lsp = {
        --   init_options = {
        --     formatter = "rubocop",
        --     linters = { "rubocop" },
        --   },
        --   cmd = { "bundle", "exec", "ruby-lsp" },
        --   filetypes = { "ruby" },
        --   root_dir = require("lspconfig.util").root_pattern("Gemfile", ".git"),
        --   settings = {
        --     ruby = {
        --       completion = {
        --         autoRequire = "enabled",
        --         useBundler = "enabled",
        --       },
        --     },
        --   },
        -- },
        tailwindcss = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
              },
            },
          },
        },
      }

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })

      -- Define common handlers with border
      local border = {
        { "┌", "FloatBorder" },
        { "─", "FloatBorder" },
        { "┐", "FloatBorder" },
        { "│", "FloatBorder" },
        { "┘", "FloatBorder" },
        { "─", "FloatBorder" },
        { "└", "FloatBorder" },
        { "│", "FloatBorder" },
      }

      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          virtual_text = false,
          underline = true,
          signs = true,
          update_in_insert = true,
        }),
      }

      -- Configure diagnostic appearance
      vim.diagnostic.config({
        virtual_text = false,
        float = { border = border },
      })

      -- Setup each server
      mason_lspconfig.setup_handlers({
        function(server_name)
          local opts = {
            capabilities = capabilities,
            handlers = handlers,
            settings = servers[server_name] and servers[server_name].settings,
            filetypes = servers[server_name] and servers[server_name].filetypes,
            cmd = servers[server_name] and servers[server_name].cmd,
            root_dir = servers[server_name] and servers[server_name].root_dir,
            init_options = servers[server_name] and servers[server_name].init_options,
          }

          require("lspconfig")[server_name].setup(opts)
        end,
      })
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    config = function()
      require("typescript-tools").setup({
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        settings = {
          jsx_close_tag = {
            enable = true,
            filetypes = { "javascriptreact", "typescriptreact" },
          },
        },
      })
    end,
  },
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Keybindings
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function()
          local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = true }
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          -- Your existing keybindings
          bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
          bufmap("n", "gd", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>")
          bufmap("n", "gD", "<cmd>vsplit | lua vim.lsp.buf.declaration()<cr>")
          bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
          bufmap("n", "gy", "<cmd>vsplit | lua vim.lsp.buf.type_definition()<cr>")
          bufmap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
          bufmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")
          bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
          bufmap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
          bufmap("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<cr>")
        end,
      })
    end,
  },
}
