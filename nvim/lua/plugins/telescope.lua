local actions = require 'telescope.actions'
local builtin = require 'telescope.builtin'

local map = require('utils').map

-- Telescope
map('n', '<leader>ff', builtin.find_files)
map('n', '<leader>fg', builtin.live_grep)
map('n', '<leader>fb', builtin.buffers)
map('n', '<leader>fh', builtin.help_tags)
map('n', '<leader>fs', builtin.grep_string)
map('n', '<leader>fo', builtin.oldfiles)
map('n', '<leader>fq', builtin.quickfix)
map('n', '<leader>fx', builtin.git_status)
map('n', '<leader>fc', builtin.git_commits)
map('n', '<leader>fB', builtin.git_branches)

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    prompt_prefix = ' ❯ ',
    selection_caret = '❯ ',
    mappings = {
      i = {
        ['<Esc>'] = actions.close,

        ['<c-j>'] = actions.move_selection_next,
        ['<c-k>'] = actions.move_selection_previous,

        ['<s-up>'] = actions.cycle_history_prev,
        ['<s-down>'] = actions.cycle_history_next,

        ['<c-d>'] = actions.delete_buffer,

        ['<C-w>'] = function()
          vim.api.nvim_input '<c-s-w>'
        end,
      },
      n = {
        ['<Esc>'] = actions.close,
      },
    },
    file_ignore_patterns = { "node_modules", ".git" },
    path_display = { 'absolute', truncate = true },
    dynamic_preview_title = true,
    preview = {
      treesitter = false,
      hide_on_startup = false,
    },
    layout_strategy = 'vertical',
    layout_config = {
      vertical = {
        preview_height = 0.5,
        preview_cutoff = 10,
      },
    },
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
      path_display = { 'absolute', truncate = true },
    },
    live_grep = {
      path_display = { 'absolute', truncate = true },
    },
  },
}

require('telescope').load_extension 'fzf'
require('telescope').load_extension 'ui-select'
