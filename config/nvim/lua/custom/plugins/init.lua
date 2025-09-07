-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'github/copilot.vim',
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    keys = {
      { '<leader>cc', '<cmd>CopilotChatOpen<cr>', desc = 'Open Copilot Chat' },
      { '<leader>ce', ':CopilotChatExplain<cr>', mode = 'v', desc = 'Explain selected code' },
      opts = {
        enable_tool_calling = true,
        -- See the configuration section below
      },
    },
  },
  {
    'vim-test/vim-test',
    dependencies = {
      'preservim/vimux',
    },
    config = function()
      local function handle_keypress(cmd)
        local window_name = 'test'
        vim.g['VimuxRunnerType'] = 'window'
        vim.g['VimuxRunnerName'] = window_name

        local full_cmd = cmd

        vim.fn['VimuxClearTerminalScreen']()
        vim.fn['VimuxRunCommand'](full_cmd)
        vim.fn['VimuxZoomRunner']()
      end

      local function run_in_new_tmux_window_and_zoom_back_on_any_key_press(cmd)
        local nvim_window_name = 'nvim'

        local full_cmd = cmd .. " || true; echo ''; echo 'Press any key to switch back'; read -n 1; tmux select-window -t " .. nvim_window_name

        handle_keypress(full_cmd)
      end

      -- Key mappings with descriptions
      vim.api.nvim_set_keymap('n', '<leader>tr', ':TestNearest<CR>', { noremap = true, silent = true, desc = 'Run nearest test' })
      vim.api.nvim_set_keymap('n', '<leader>tt', ':TestFile<CR>', { noremap = true, silent = true, desc = 'Run all tests in file' })
      vim.api.nvim_set_keymap('n', '<leader>tl', ':TestLast<CR>', { noremap = true, silent = true, desc = 'Run last test' })

      local function run_in_bg(cmd)
        -- Escape single quotes in the command
        cmd = cmd:gsub("'", "'\\''")

        -- Send the command to tmux buffer
        vim.fn.system(string.format("tmux set-buffer '%s'", cmd))
        -- Suspend Neovim
        vim.cmd 'suspend'
        -- Paste the command, send Enter, and set up key binding to return to fg
        vim.fn.system 'tmux paste-buffer && tmux send-keys Enter && tmux bind-key -n any "send-keys fg Enter ; unbind-key -n any"'
      end

      vim.g['test#custom_strategies'] = {
        zoom_back_on_keypress = run_in_new_tmux_window_and_zoom_back_on_any_key_press,
        bg = run_in_bg,
      }

      vim.g['test#strategy'] = 'bg'
    end,
  },
  {
    'kylechui/nvim-surround',
    version = '^3.0.0', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      gitbrowse = { enabled = true },
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = {
        enabled = true,
        animate = {
          duration = 0,
        },
      },
      statuscolumn = { enabled = false },
      input = { enabled = false },
      picker = { enabled = false },
      notifier = { enabled = false },
      quickfile = { enabled = false },
      scope = { enabled = false },
      scroll = { enabled = false },
      words = { enabled = false },
    },
    keys = {
      {
        '<leader>gB',
        function()
          Snacks.gitbrowse()
        end,
        desc = 'Git Browse',
        mode = { 'n', 'v' },
      },
    },
  },
  {
    'klen/nvim-config-local',
    config = function()
      require('config-local').setup {
        config_files = {
          '.nvim.lua',
        },
      }
    end,
  },
}
