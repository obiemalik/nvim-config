local actions = require 'telescope.actions'
local builtin = require 'telescope.builtin'

local map = require('utils').map

map('n', '<leader>fb', builtin.buffers)
map('n', '<leader>fh', builtin.help_tags)
map('n', '<leader>fo', builtin.oldfiles)
map('n', '<leader>fq', builtin.quickfix)

map('n', '<leader>fx', builtin.git_status)
map('n', '<leader>fc', builtin.git_commits)
map('n', '<leader>fg', builtin.git_branches)

-- Telescope
map('n', '<leader>ff', builtin.find_files)
map('n', '<leader>fg', builtin.live_grep)
map('n', '<leader>fb', builtin.buffers)
map('n', '<leader>fh', builtin.help_tags)
map('n', '<leader>fs', builtin.grep_string)

require('telescope').setup {
  defaults = {
    prompt_prefix = ' ❯ ',
    selection_caret = '❯ ',
    mappings = {
      i = {
        ['<esc>'] = actions.close,

        ['<c-j>'] = actions.move_selection_next,
        ['<c-k>'] = actions.move_selection_previous,

        ['<s-up>'] = actions.cycle_history_prev,
        ['<s-down>'] = actions.cycle_history_next,

        ['<c-d>'] = actions.delete_buffer,

        ['<C-w>'] = function()
          vim.api.nvim_input '<c-s-w>'
        end,
      },
    },
    file_ignore_patterns = { "node_modules", ".git" },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
    ['ui-select'] = {
      require('telescope.themes').get_dropdown {},
    },
  },
  pickers = {
    oldfiles = {
      sort_lastused = true,
      cwd_only = true,
    },
    buffers = {
      sort_lastused = true
    },
    find_files = {
      hidden = false,
    },
    live_grep = {
      path_display = { 'shorten' },
    },
  },
}

require('telescope').load_extension 'fzf'
