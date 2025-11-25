-----------------------------------------------------------
-- Interactive Color Scheme Picker
-----------------------------------------------------------

local statusline = require('core/statusline')

local Schemes = nil
local scheme_variants = nil

local function apply_scheme(scheme_name, variant)
  if not Schemes then
    print("Color schemes not initialized")
    return
  end
  local full_name = variant and variant ~= 'default' and (scheme_name .. '-' .. variant) or scheme_name
  local scheme_module = Schemes[scheme_name]
  scheme_module.apply(full_name)
  local statusline_colors = scheme_module.get_statusline(full_name)
  statusline.feline.use_theme(statusline_colors)
end

local function show_scheme_picker()
  if not Schemes or not scheme_variants then
    print("Color schemes not initialized")
    return
  end
  -- Build list of schemes
  local scheme_list = {}
  for scheme_name, _ in pairs(Schemes) do
    table.insert(scheme_list, scheme_name)
  end
  table.sort(scheme_list)

  vim.ui.select(scheme_list, {
    prompt = 'Select color scheme: ',
    format_item = function(item)
      return item
    end
  }, function(choice)
    if not choice then
      return
    end

    -- Get variants for selected scheme
    local variants = scheme_variants[choice] or { 'default' }

    vim.ui.select(variants, {
      prompt = 'Select ' .. choice .. ' variant: ',
      format_item = function(item)
        return item
      end
    }, function(variant_choice)
      if not variant_choice then
        return
      end
      apply_scheme(choice, variant_choice)
    end)
  end)
end

return {
  init = function(schemes, variants)
    Schemes = schemes
    scheme_variants = variants
  end,
  show_scheme_picker = show_scheme_picker,
  apply_scheme = apply_scheme
}
