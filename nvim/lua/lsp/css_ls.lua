-- https://github.com/vscode-langservers/vscode-css-languageserver-bin
require('lspconfig').cssls.setup {
  on_attach = require('lsp').on_attach,
  capabilities = require('lsp').capabilities,
}
