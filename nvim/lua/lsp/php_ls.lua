-- https://intelephense.com
require('lspconfig').intelephense.setup {
  on_attach = require('lsp').on_attach,
  capabilities = require('lsp').capabilities,
  settings = {
    intelephense = {
      environment = {
        shortOpenTag = true
      }
    }
  }
}
