local util = require 'lspconfig.util'

-- https://github.com/graphql/graphiql/tree/main/packages/graphql-language-service-cli
require('lspconfig').graphql.setup {
  on_attach = require('lsp').on_attach,
  capabilities = require('lsp').capabilities,
  root_dir = util.root_pattern('.graphqlrc.yml', '.graphqlrc'),
  filetypes = { 'graphql' },
}
