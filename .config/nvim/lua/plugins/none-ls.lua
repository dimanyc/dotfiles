return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"davidmh/cspell.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local cspell = require("cspell")

		local config = {
			cspell_config_dirs = { "~/.config/cspell" },
		}

		null_ls.setup({
			sources = {
				-- Spelling and general sources
				cspell.diagnostics.with({ config = config }),
				cspell.code_actions.with({ config = config }),

				-- Linters
				null_ls.builtins.diagnostics.erb_lint,
				null_ls.builtins.diagnostics.rubocop,
				-- null_ls.builtins.diagnostics.shfmt,
				-- null_ls.builtins.diagnostics.shellcheck,

				-- Formatters
				-- null_ls.builtins.formatting.stylua,
				-- null_ls.builtins.formatting.prettierd,
				-- null_ls.builtins.formatting.shfmt,
			},
			debug = true,
		})

		-- Format on pressing <leader>d
		-- vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format" })

		-- Optional: Format on save (modified to exclude Ruby/ERB)
		-- vim.api.nvim_create_autocmd("BufWritePre", {
		--   callback = function()
		--     vim.lsp.buf.format()
		--   end,
		-- })
	end,
}
