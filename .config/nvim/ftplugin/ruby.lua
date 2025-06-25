vim.keymap.set('n', '<leader>d', function()
  -- Insert "require 'pry'" at the top of the buffer if not present
  local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
  if not first_line or not first_line:match 'require [\'"]pry[\'"]' then
    vim.api.nvim_buf_set_lines(0, 0, 0, false, { "require 'pry'" })
  end
  -- Insert "binding.pry" under the cursor
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_lines(0, row, row, false, { 'binding.pry' })
end, { desc = 'Insert require pry and binding.pry' })
