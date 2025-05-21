return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
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
		gitbrowse = {
			enabled = true,
		},
	},

	keys = {
		{

			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
			mode = { "n", "v" },
		},
		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Git Blame Line",
		},
	},
}
