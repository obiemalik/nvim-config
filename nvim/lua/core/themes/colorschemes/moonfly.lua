-- moonfly
local status_ok, colorscheme = pcall(require, 'moonfly')
if not status_ok then
  return
end

local function apply()
  vim.cmd [[colorscheme moonfly]]
end

return {
  apply = apply,
  get_statusline = function()
    return colorscheme.palette
  end
}
