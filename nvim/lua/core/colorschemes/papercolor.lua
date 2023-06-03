-- PaperColor
vim.g.PaperColor_Theme_Options = {
  theme = {
    default = {
      override = {
        color00 = { '#ffffff', '000' },
        linenumber_bg = { '#ffffff', '000' }
      }
    }
  }
}

vim.cmd('colorscheme PaperColor')
vim.o.background = 'light'

-- statusline

local M = {}

M.statusline = {
  bg = '#fafafa',
  fg = '#202328',
  pink = '#f92672',
  green = '#00cc00',
  cyan = '#66d9ef',
  yellow = '#ffee55',
  orange = '#fd971f',
  red = '#ea5445',
}

return M
