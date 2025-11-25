-- OxoCarbon styles: dark, light (controlled via vim.opt.background)
local status_ok, colorscheme = pcall(require, 'oxocarbon')
if not status_ok then
  return
end

local statusline_colors = {
  bg = '#282c34',
  fg = '#b2bbcc',
  pink = '#c678dd',
  green = '#98c379',
  cyan = '#56b6c2',
  yellow = '#e5c07b',
  orange = '#d19a66',
  red = '#e86671',
}

local function apply(scheme)
  -- Extract style from scheme name (e.g., "oxocarbon-light" -> "light")
  local style = 'dark'
  local index = string.find(scheme, '-')
  if index ~= nil then
    style = string.sub(scheme, index + 1)
  end
  
  -- Set background before loading colorscheme
  vim.opt.background = style
  vim.cmd('colorscheme oxocarbon')
end

return {
  apply = apply,
  get_statusline = function()
    return statusline_colors
  end
}
