-----------------------------------------------------------
-- Color schemes configuration file
-----------------------------------------------------------

local print_table = require('utils').print_table
local Schemes = {
  catppuccin = require('core/colorschemes/catppuccin'),
  papercolor = require('core/colorschemes/papercolor'),
  onedark = require('core/colorschemes/onedark')
}

local statusline = require('core/statusline')

---

local function findSchemeNameByPartialName(tbl, partialName)
  for key, _ in pairs(tbl) do
    if string.find(key, partialName) or string.find(partialName, key) then
      return key
    end
  end
  return nil
end

---

vim.cmd('command! -nargs=1 SetColorScheme lua SetColorScheme(<f-args>)')

function SetColorScheme(name)
  local schemename = findSchemeNameByPartialName(Schemes, name)
  local scheme = Schemes[schemename]:new(name)

  scheme:apply()
  statusline.feline.use_theme(scheme.statusline)
end

SetColorScheme("catppuccin-frappe");
