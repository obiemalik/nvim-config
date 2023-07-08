-- OneDark styles: dark, darker, cool, deep, warm, warmer, light
local status_ok, colorscheme = pcall(require, 'onedark')
if not status_ok then
  return
end

local OneDark = {}

function OneDark:new(scheme)
  local instance = {}

  setmetatable(instance, self)
  self.__index = self

  instance.scheme = scheme
  instance.statusline = {
    bg = '#282c34',
    fg = '#b2bbcc',
    pink = '#c678dd',
    green = '#98c379',
    cyan = '#56b6c2',
    yellow = '#e5c07b',
    orange = '#d19a66',
    red = '#e86671',
  }

  return instance
end

function OneDark:apply()
  local style = 'cool'

  local index = string.find(self.scheme, '-')
  if index ~= nil then
    style = string.sub(self.scheme, index + 1, string.len(self.scheme))
  end

  colorscheme.setup {
    styles = style,
    colors = { fg = '#eee' }, --default: #a0a8b7
  }

  colorscheme.load()
end

return OneDark
