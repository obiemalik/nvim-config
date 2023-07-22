-----------------------------------------------------------
-- Color schemes configuration file
-----------------------------------------------------------

local StatusLine = require('core/statusline')
local Schemes = {
  catppuccin = require('core/colorschemes/catppuccin'),
  papercolor = require('core/colorschemes/papercolor'),
  onedark = require('core/colorschemes/onedark')
}

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
  local statusline = StatusLine:new(scheme.statusline)

  scheme:apply()
  statusline:apply()
end

SetColorScheme("catppuccin-latte");

