-- modus
local status_ok, colorscheme = pcall(require, 'modus-themes')
if not status_ok then
  return
end

local statusline_colors = {}

local function apply()
  colorscheme.setup {
    variant = "deuteranopia",
    on_colors = function(colors)
      statusline_colors = colors
      colors.bg_main = colors.bg_inactive
    end
  }

  vim.cmd([[colorscheme modus]])
end

return {
  apply = apply,
  get_statusline = function()
    return statusline_colors
  end
}
