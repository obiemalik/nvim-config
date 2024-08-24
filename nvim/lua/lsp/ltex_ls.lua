-- https://github.com/valentjn/ltex-ls
require('lspconfig').ltex.setup {
  on_attach = require('lsp').on_attach,
  capabilities = require('lsp').capabilities,
}
