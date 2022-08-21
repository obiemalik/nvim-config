-- https://github.com/valentjn/ltex-ls
require('lspconfig').ltex.setup {
  cmd = { 'usr/local/bin/ltex-ls' },
  on_attach = require('lsp').on_attach,
  capabilities = require('lsp').capabilities,
}
