-- https://github.com/theia-ide/typescript-language-server

require('typescript').setup {
  server = {
    on_attach = require('lsp').on_attach,
    capabilities = require('lsp').capabilities
  }
}
