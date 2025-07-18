-----------------------------------------------------------
-- Color schemes configuration file
-----------------------------------------------------------

local Schemes = {
  catppuccin = require('core/colorschemes/catppuccin'),
  papercolor = require('core/colorschemes/papercolor'),
  onedark = require('core/colorschemes/onedark'),
  modus = require('core/colorschemes/modus'),
  moonfly = require('core/colorschemes/moonfly')
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
vim.cmd('command! ResetColorScheme lua ResetColorScheme()')

function SetColorScheme(name)
  local schemename = findSchemeNameByPartialName(Schemes, name)
  if schemename then
    local scheme = Schemes[schemename]:new(name)
    scheme:apply()
    statusline.feline.use_theme(scheme.statusline)
  else
    print("Color scheme not found: " .. name)
  end
end

function ResetColorScheme()
  -- Check if running on macOS
  local uname = vim.fn.system('uname'):gsub('%s+', '')

  if uname == 'Darwin' then
    -- Get Warp's theme
    local handle = io.popen("defaults read dev.warp.Warp-Stable Theme 2>/dev/null")
    if handle then
      local result = handle:read("*a")
      handle:close()

      if result and string.find(result, "Light") then
        SetColorScheme("papercolor")
      else
        SetColorScheme("moonfly")
      end
    else
      -- Fallback if can't read defaults
      SetColorScheme("moonfly")
    end
  else
    -- Fallback for non-macOS systems
    SetColorScheme("moonfly")
  end
end

-- Auto-detect theme on startup
ResetColorScheme()
