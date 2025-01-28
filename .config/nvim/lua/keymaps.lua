-- Function to insert the appropriate debug statement
local function insert_debug_statement()
	local filetype = vim.bo.filetype
	local word_under_cursor = vim.fn.expand("<cword>") -- Get the word under the cursor
	local debug_statement

	if filetype == "ruby" then
		debug_statement = "binding.pry"
	elseif
		filetype == "javascript"
		or filetype == "typescript"
		or filetype == "javascriptreact"
		or filetype == "typescriptreact"
	then
		debug_statement = string.format("console.log('%s:', %s)", word_under_cursor, word_under_cursor)
	else
		print("Unsupported file type for debug statement insertion.")
		return
	end

	-- Insert the debug statement below the current line
	local current_line = vim.fn.line(".")
	vim.fn.append(current_line, debug_statement)
end

-- Create a command to call the function
vim.api.nvim_create_user_command("InsertDebug", insert_debug_statement, {})

-- Optionally, map a key to call the command
vim.api.nvim_set_keymap("n", "<leader>p", ":InsertDebug<CR>", { noremap = true, silent = true })
