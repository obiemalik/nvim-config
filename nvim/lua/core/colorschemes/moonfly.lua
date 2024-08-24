-- monokai
local status_ok, colorscheme = pcall(require, 'moonfly')
if not status_ok then
  return
end

local Moonfly = {}

function Moonfly:new(scheme)
  local instance = {}

  setmetatable(instance, self)
  self.__index = self

  instance.scheme = scheme
  instance.statusline = colorscheme.palette

  return instance
end

function Moonfly:apply()
  vim.cmd [[colorscheme moonfly]]
end

return Moonfly
