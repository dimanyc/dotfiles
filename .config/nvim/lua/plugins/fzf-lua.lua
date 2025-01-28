return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		require("fzf-lua").setup({ "fzf-vim" })
		local fzf = require("fzf-lua")
		-- local actions = fzf.actions

		vim.keymap.set("n", "<C-p>", fzf.files, { desc = "FZF find files" })
		vim.keymap.set("n", "<leader>h", fzf.oldfiles, { desc = "FZF history" })
		vim.keymap.set("n", "<leader>b", fzf.buffers, { desc = "FZF buffers" })
		vim.keymap.set("n", "<leader>s", fzf.grep_cword, { desc = "FZF grep" })
		vim.keymap.set("n", "gr", fzf.lsp_references, { desc = "FZF references" })
		vim.keymap.set("n", "<leader>ac", fzf.lsp_code_actions, { desc = "FZF code actions" })
		vim.keymap.set("n", "<leader>ic", fzf.lsp_incoming_calls, { desc = "FZF incoming calls" })
		fzf.setup({
			files = {
				previewer = {
					cmd = "bat",
					args = "--style=numbers,changes --color always",
				},
			},
			lsp = {
				prompt_postfix = "Lsp❯ ",
				cwd_only = true,
				-- async_or_timeout = 5000,
				file_icons = false,
				git_icons = false,
			},
		})
		-- files = {
		--   multiprocess = true,
		--   git_icons = false,
		--   file_icons = false,
		--   color_icons = false,
		-- },
		-- })
	end,
}
