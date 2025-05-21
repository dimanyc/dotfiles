return {
	{ "williamboman/mason.nvim", config = true },

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
			"ibhagwan/fzf-lua",
		},
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			mason.setup({})

			-- list every server you want Mason to install & configure
			local servers = {
				lua_ls = { Lua = { diagnostics = { globals = { "vim" } } } },
				ruby_lsp = {},
				html = {},
				eslint = {},
				tailwindcss = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								"[a-zA-Z]*ClassName='([^']+)'",
								'[a-zA-Z]*ClassName="([^"]+)"',
								"[a-zA-Z]*ClassName={`([^`]+)`}",
							},
						},
					},
				},
				vtsls = {}, -- ← TypeScript/JS/TSX via vtsls
			}

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({
							capabilities = capabilities,
							settings = servers[server_name],
						})
					end,
				},
			})

			vim.diagnostic.config({ virtual_text = false }) -- no inline diagnostics

			-- key-bindings (unchanged)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = { buffer = event.buf }
					local fzf = require("fzf-lua")

					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "gd", fzf.lsp_definitions, opts)
					vim.keymap.set("n", "gr", fzf.lsp_references, opts)
					vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "gy", fzf.lsp_typedefs, opts)
					vim.keymap.set("n", "<leader>ic", fzf.lsp_incoming_calls, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ac", fzf.lsp_code_actions, opts)
					vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
					vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)
				end,
			})
		end,
	},
}
