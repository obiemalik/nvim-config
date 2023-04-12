require('lspconfig').pylsp.setup {
  on_attach = require('lsp').on_attach,
  capabilities = require('lsp').capabilities,
  settings = {
    pylsp = {
      plugins = {
        flake8 = {
          enabled = true
        }
      },
      formatting = {
        provider = "flake8"
      }
    }
  }
}

