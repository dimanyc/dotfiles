return {
	"vim-test/vim-test",
	dependencies = {
		"preservim/vimux",
	},
	config = function()
		local function handle_keypress(cmd)
			local window_name = "test"
			vim.g["VimuxRunnerType"] = "window"
			vim.g["VimuxRunnerName"] = window_name

			local full_cmd = cmd

			vim.fn["VimuxClearTerminalScreen"]()
			vim.fn["VimuxRunCommand"](full_cmd)
			vim.fn["VimuxZoomRunner"]()
		end

		local function run_in_new_tmux_window_and_zoom_back_on_any_key_press(cmd)
			local nvim_window_name = "nvim"

			local full_cmd = cmd
				.. " || true; echo ''; echo 'Press any key to switch back'; read -n 1; tmux select-window -t "
				.. nvim_window_name

			handle_keypress(full_cmd)
		end

		-- Key mappings with descriptions
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tn",
			":TestNearest<CR>",
			{ noremap = true, silent = true, desc = "Run nearest test" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tf",
			":TestFile<CR>",
			{ noremap = true, silent = true, desc = "Run all tests in file" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tl",
			":TestLast<CR>",
			{ noremap = true, silent = true, desc = "Run last test" }
		)

		local function run_in_bg(cmd)
			-- Escape single quotes in the command
			cmd = cmd:gsub("'", "'\\''")

			-- Send the command to tmux buffer
			vim.fn.system(string.format("tmux set-buffer '%s'", cmd))
			-- Suspend Neovim
			vim.cmd("suspend")
			-- Paste the command, send Enter, and set up key binding to return to fg
			vim.fn.system(
				'tmux paste-buffer && tmux send-keys Enter && tmux bind-key -n any "send-keys fg Enter ; unbind-key -n any"'
			)
		end

		vim.g["test#custom_strategies"] = {
			zoom_back_on_keypress = run_in_new_tmux_window_and_zoom_back_on_any_key_press,
			bg = run_in_bg,
		}

		vim.g["test#strategy"] = "bg"
	end,
}
