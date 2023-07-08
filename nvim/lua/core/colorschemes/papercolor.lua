-- PaperColor
local PaperColor = {}

function PaperColor:new()
  local instance = {}

  setmetatable(instance, self)
  self.__index = self

  instance.statusline = {
    bg = '#fafafa',
    fg = '#202328',
    pink = '#f92672',
    green = '#00cc00',
    cyan = '#66d9ef',
    yellow = '#ffee55',
    orange = '#fd971f',
    red = '#ea5445',
  }

  return instance
end

function PaperColor:apply()
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
end

return PaperColor
