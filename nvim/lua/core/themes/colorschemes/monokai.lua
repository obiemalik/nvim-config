-- monokai
local status_ok, colorscheme = pcall(require, 'monokai')
if not status_ok then
  return
end

local statusline_colors = {
  bg = '#202328', --default: #272a30
  fg = '#f8f8f0',
  pink = '#f92672',
  green = '#a6e22e',
  cyan = '#66d9ef',
  yellow = '#e6db74',
  orange = '#fd971f',
  red = '#e95678',
}

local function apply(scheme)
  local style = 'pro'

  local index = string.find(scheme, '-')
  if index ~= nil then
    style = string.sub(scheme, index + 1, string.len(scheme))
  end

  colorscheme.setup { palette = require('monokai')[style] }
end

return {
  apply = apply,
  get_statusline = function()
    return statusline_colors
  end
}
