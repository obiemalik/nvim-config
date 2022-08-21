require('lspconfig').hls.setup {
  on_attach = require('lsp').on_attach,
  capabilities = require('lsp').capabilities
}
