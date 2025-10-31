local read_package_json = require('utils').read_package_json

local package_json = read_package_json()

-- Check for any Tailwind-related dependencies
local function has_tailwind_dependencies()
  if not package_json then
    return false
  end

  local deps = package_json.dependencies or {}
  local dev_deps = package_json.devDependencies or {}

  -- Check for common Tailwind-related packages
  local tailwind_packages = {
    'tailwindcss',
    'windicss',
    '@tailwindcss/forms',
    '@tailwindcss/typography',
    '@tailwindcss/aspect-ratio',
    '@tailwindcss/container-queries'
  }

  for _, pkg in ipairs(tailwind_packages) do
    if deps[pkg] or dev_deps[pkg] then
      return true
    end
  end

  return false
end

-- Only setup Tailwind LSP if we actually have Tailwind dependencies
if has_tailwind_dependencies() then
  vim.lsp.config('tailwindcss', {})
  vim.lsp.enable('tailwindcss')
end
