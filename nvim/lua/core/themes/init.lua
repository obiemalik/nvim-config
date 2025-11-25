
local Schemes = {
  catppuccin = require('core/themes/colorschemes/catppuccin'),
  papercolor = require('core/themes/colorschemes/papercolor'),
  onedark = require('core/themes/colorschemes/onedark'),
  modus = require('core/themes/colorschemes/modus'),
  moonfly = require('core/themes/colorschemes/moonfly'),
  oxocarbon = require('core/themes/colorschemes/oxocarbon'),
  monokai = require('core/themes/colorschemes/monokai')
}

-- Define available styles for each scheme
local scheme_variants = {
  catppuccin = { 'latte', 'frappe', 'macchiato', 'mocha', 'amoled' },
  papercolor = { 'light', 'dark' },
  onedark = { 'default', 'darker', 'cool', 'warm', 'warmer' },
  modus = { 'operandi', 'vivendi' },
  moonfly = { 'default' },
  oxocarbon = { 'dark', 'light' },
  monokai = { 'pro', 'soda', 'ristretto' }
}

-- Load color functions and pass Schemes
local colors = require('core/themes/colors')
colors.init(Schemes)

-- Setup commands
local picker = require('core/themes/colors_picker')
picker.init(Schemes, scheme_variants)

vim.cmd('command! -nargs=1 SetColorScheme lua require("core/themes/colors").SetColorScheme(<f-args>)')
vim.cmd('command! ResetColorScheme lua require("core/themes/colors").ResetColorScheme()')
vim.cmd('command! ColorSchemePicker lua require("core/themes/colors_picker").show_scheme_picker()')

return {
  Schemes = Schemes,
  scheme_variants = scheme_variants
}

