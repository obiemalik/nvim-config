require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = { -- :h background
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
  no_bold = false, -- Force no bold
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
      text = '#000000',
      base = '#ffffff',
      mantle = '#ffffff',
      crust = '#ffffff',
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


local schemes = { 'catppuccin', 'catppuccin-latte', 'catppuccin-frappe', 'catppuccin-macchiato', 'catppuccin-mocha',
  'catppuccin-amoled' }
vim.cmd.colorscheme(schemes[3])
-- statusline
local M = {}

local latte = require("catppuccin.palettes").get_palette "latte"
local frappe = require("catppuccin.palettes").get_palette "frappe"
local macchiato = require("catppuccin.palettes").get_palette "macchiato"
local mocha = require("catppuccin.palettes").get_palette "mocha"

M.statusline = latte
-- M.statusline = {
--   bg = '#282c34',
--   fg = '#b2bbee',
--   pink = '#ef9ecf',
--   green = '#98c379',
--   cyan = '#56b6c2',
--   yellow = '#e5c07b',
--   orange = '#d19a66',
--   red = '#e86671',
-- }

return M
