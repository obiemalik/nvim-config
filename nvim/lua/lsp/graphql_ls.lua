local util = require 'lspconfig.util'

-- https://github.com/graphql/graphiql/tree/main/packages/graphql-language-service-cli
vim.lsp.config('graphql', {
  root_dir = util.root_pattern('.graphqlrc.yml', '.graphqlrc'),
  filetypes = { 'graphql' },
})
vim.lsp.enable('graphql')
