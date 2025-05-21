return {
	"ibhagwan/fzf-lua",
	dependencies = { "echasnovski/mini.icons" },

	config = function()
		require("fzf-lua").setup({
			keymap = {
				fzf = {
					["ctrl-a"] = "select-all+accept",
					["ctrl-d"] = "preview-half-page-down",
					["ctrl-u"] = "preview-half-page-up",
				},
			},
			previewers = {
				cat = {
					cmd = "cat",
					args = "-n",
				},
				bat = {
					cmd = "bat",
					args = "--color=always --style=numbers,changes",
				},
			},
			files = {
				previewer = "bat",
			},
		})
		require("fzf-lua").setup({ "fzf-vim" })
		local fzf = require("fzf-lua")

		vim.keymap.set("n", "<C-p>", fzf.files, { desc = "FZF find files" })
		vim.keymap.set("n", "<leader>h", fzf.oldfiles, { desc = "FZF history" })
		vim.keymap.set("n", "<leader>b", fzf.buffers, { desc = "FZF buffers" })
		vim.keymap.set("n", "<leader>s", fzf.grep_cword, { desc = "FZF grep" })
	end,
}
