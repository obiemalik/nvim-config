-----------------------------------------------------------
-- Color schemes configuration file
-----------------------------------------------------------

local statusline = require('core/statusline')

local Schemes = nil

local function findSchemeNameByPartialName(tbl, partialName)
  for key, _ in pairs(tbl) do
    if string.find(key, partialName) or string.find(partialName, key) then
      return key
    end
  end
  return nil
end

local function SetColorScheme(name)
  if not Schemes then
    print("Color schemes not initialized")
    return
  end
  local schemename = findSchemeNameByPartialName(Schemes, name)
  if schemename then
    local scheme_module = Schemes[schemename]
    scheme_module.apply(name)
    local statusline_colors = scheme_module.get_statusline(name)
    statusline.feline.use_theme(statusline_colors)
  else
    print("Color scheme not found: " .. name)
  end
end

local function ResetColorScheme(default_name)
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
        SetColorScheme(default_name)
      end
    else
      -- Fallback if can't read defaults
      SetColorScheme(default_name)
    end
  else
    -- Fallback for non-macOS systems
    SetColorScheme(default_name)
  end
end

return {
  init = function(schemes)
    Schemes = schemes
    -- Auto-detect theme on startup
    ResetColorScheme("modus")
  end,
  SetColorScheme = SetColorScheme,
  ResetColorScheme = ResetColorScheme
}
