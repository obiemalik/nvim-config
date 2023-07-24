local status_c_ok, colorscheme = pcall(require, 'catppuccin')
if not status_c_ok then
  return
end

local status_p_ok, palletes = pcall(require, 'catppuccin.palettes')
if not status_p_ok then
  return
end


colorscheme.setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = {     -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false,
  term_colors = false,
  dim_inactive = {
    enabled = true,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = false, -- Force no italic
  no_bold = false,   -- Force no bold
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {
    latte = {
      text = '#333333',
      base = '#ffffff',
      mantle = '#ffffff',
      crust = '#f0f0f0',
    },
  },
  custom_highlights = {},
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    telescope = true,
    notify = false,
    mini = false,
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})


-- statusline

local function get_colors(scheme)
  local pallete = 'latte'

  local index = string.find(scheme, '-')
  if index ~= nil then
    pallete = string.sub(scheme, index + 1, string.len(scheme))
  end

  -- update colors to conform to statusline reqs
  local colors = palletes.get_palette(pallete)

  colors.bg = colors.crust
  colors.fg = colors.text

  return colors
end

local Catppuccin = {}

--- Set colorscheme to one of the following themes:
-- 'catppuccin',
-- 'catppuccin-latte',
-- 'catppuccin-frappe',
-- 'catppuccin-macchiato',
-- 'catppuccin-mocha',
-- 'catppuccin-amoled'
---@param scheme string
function Catppuccin:new(scheme)
  local instance = {}

  setmetatable(instance, self)
  self.__index = self

  local pallete = get_colors(scheme)

  instance.scheme = scheme
  instance.statusline = pallete

  return instance
end

function Catppuccin:apply()
  vim.cmd.colorscheme(self.scheme)
end

return Catppuccin
