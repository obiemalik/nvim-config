-- rose-pine
local status_ok, colorscheme = pcall(require, 'rose-pine')
if not status_ok then
  return
end

colorscheme.setup {}
colorscheme.load()

-- statusline
local M = {}

M.statusline = {
  bg = '#111019', --default: #191724
  fg = '#e0def4',
  pink = '#eb6f92',
  green = '#9ccfd8',
  cyan = '#31748f',
  yellow = '#f6c177',
  orange = '#2a2837',
  red = '#ebbcba',
}

return M
