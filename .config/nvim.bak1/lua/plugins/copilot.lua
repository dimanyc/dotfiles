return {
	"github/copilot.vim",
	event = "VimEnter", -- Load on VimEnter to ensure Neovim is ready
	config = function()
		-- Optional: customize Copilot settings
		vim.g.copilot_filetypes = {
			["*"] = true, -- Enable for all file types
		}
		vim.g.copilot_no_comment = true -- Allow Copilot to suggest in comments
		-- You can add more configurations as needed
	end,
}
