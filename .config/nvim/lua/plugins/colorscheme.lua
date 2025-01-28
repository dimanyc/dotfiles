return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = function()
		require("gruvbox").setup({
			overrides = {
				SignColumn = { link = "Normal" },
				GruvboxGreenSign = { bg = "" },
				GruvboxOrangeSign = { bg = "" },
				GruvboxPurpleSign = { bg = "" },
				GruvboxYellowSign = { bg = "" },
				GruvboxRedSign = { bg = "" },
				GruvboxBlueSign = { bg = "" },
				GruvboxAquaSign = { bg = "" },
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
