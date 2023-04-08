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
