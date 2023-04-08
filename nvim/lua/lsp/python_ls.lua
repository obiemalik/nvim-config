require('lspconfig').pylsp.setup {
  on_attach = require('lsp').on_attach,
  capabilities = require('lsp').capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'W391' },
          maxLineLength = 80
        }
      }
    }
  }
}
