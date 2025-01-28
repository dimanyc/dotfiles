vim.cmd("set clipboard=unnamed")
vim.cmd("highlight SignColumn guibg=bg1")
vim.cmd("set signcolumn=yes")
vim.cmd("set noswapfile")
vim.cmd("set colorcolumn=80")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set shell=/bin/zsh")

-- Function to suspend Neovim and run a shell command
local function suspend_and_run(command)
	-- Suspend Neovim
	os.execute("kill -s SIGTSTP $(pgrep -n nvim)")

	-- Run the command
	os.execute(command)
end

-- Create a command in Neovim to use this function
vim.api.nvim_create_user_command("RunInBackground", function(opts)
	local command = opts.args
	suspend_and_run(command)
end, { nargs = 1 }) -- Accept one argument (the command to run)
