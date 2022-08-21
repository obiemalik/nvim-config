local read_package_json = require('utils').read_package_json

local package_json = read_package_json()

local have_tailwindish_styling = package_json and package_json.devDependencies.windicss

if have_tailwindish_styling then
  require('lspconfig').tailwindcss.setup {
    on_attach = require('lsp').on_attach,
    capabilities = require('lsp').capabilities
  }
end
