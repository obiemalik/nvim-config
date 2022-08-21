local util = require 'lspconfig.util'

require('lspconfig').eslint.setup {
  root_dir = util.root_pattern('.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json'),
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true

    require('lsp').on_attach(client, bufnr)
  end,
}
