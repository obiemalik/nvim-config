-- OxoCarbon styles: dark, darker, cool, deep, warm, warmer, light
local status_ok, colorscheme = pcall(require, 'oxocarbon')
if not status_ok then
  return
end

local OxoCarbon = {}

function OxoCarbon:new(scheme)
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

function OxoCarbon:apply()
  vim.cmd('colorscheme oxocarbon')
  vim.opt.background = 'dark'
end

return OxoCarbon
