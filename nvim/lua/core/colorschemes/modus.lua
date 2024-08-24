-- monokai
local status_ok, colorscheme = pcall(require, 'modus-themes')
if not status_ok then
  return
end

local Modus = {}

function Modus:new(scheme)
  local instance = {}

  setmetatable(instance, self)
  self.__index = self

  instance.scheme = scheme
  instance.statusline = {}

  return instance
end

function Modus:apply()
  colorscheme.setup {
    on_colors = function(colors)
      self.statusline = colors
    end
  }

  vim.cmd([[colorscheme modus]])
end

return Modus
