-- monokai
local status_ok, colorscheme = pcall(require, 'monokai')
if not status_ok then
  return
end

colorscheme.setup {}
colorscheme.load()

-- statusline
local M = {}

M.statusline = {
  bg = '#202328', --default: #272a30
  fg = '#f8f8f0',
  pink = '#f92672',
  green = '#a6e22e',
  cyan = '#66d9ef',
  yellow = '#e6db74',
  orange = '#fd971f',
  red = '#e95678',
}

return M
