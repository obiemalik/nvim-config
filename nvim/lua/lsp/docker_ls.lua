-- https://github.com/rcjsuen/dockerfile-language-server-nodejs
require('lspconfig').dockerls.setup {
  on_attach = require('lsp').on_attach,
  capabilities = require('lsp').capabilities,
}
