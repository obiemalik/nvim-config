local lsp = require('lsp')

require('lspconfig').prismals.setup {
  on_attach = lsp.on_attach,
  capabilities = lsp.capabilities
}
