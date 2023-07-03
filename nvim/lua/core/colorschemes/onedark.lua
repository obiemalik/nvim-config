-- OneDark styles: dark, darker, cool, deep, warm, warmer, light
local status_ok, colorscheme = pcall(require, 'onedark')
if not status_ok then
  return
end

colorscheme.setup {
  styles = 'cool', --'warm',
  colors = { fg = '#eee' }, --default: #a0a8b7
}

colorscheme.load()


-- statusline
local M = {}

-- Colors:
-- https://github.com/navarasu/onedark.nvim/blob/master/lua/onedark/palette.lua
M.statusline = {
  bg = '#282c34',
  fg = '#b2bbcc',
  pink = '#c678dd',
  green = '#98c379',
  cyan = '#56b6c2',
  yellow = '#e5c07b',
  orange = '#d19a66',
  red = '#e86671',
}

return M
