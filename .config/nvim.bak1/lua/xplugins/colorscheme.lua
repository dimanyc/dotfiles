return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			overrides = {
				signcolumn = { link = "normal" },
				gruvboxgreensign = { bg = "" },
				gruvboxorangesign = { bg = "" },
				gruvboxpurplesign = { bg = "" },
				gruvboxyellowsign = { bg = "" },
				gruvboxredsign = { bg = "" },
				gruvboxbluesign = { bg = "" },
				gruvboxaquasign = { bg = "" },
			},
			vim.cmd("colorscheme gruvbox"),
		})
	end,
}
-- return {
-- 	"neanias/everforest-nvim",
-- 	version = false,
-- 	lazy = false,
-- 	priority = 1000, -- make sure to load this before all the other start plugins
-- 	-- Optional; default configuration will be used if setup isn't called.
-- 	config = function()
-- 		require("everforest").setup({
-- 			vim.cmd("colorscheme everforest"),
-- 		})
-- 	end,
-- }
