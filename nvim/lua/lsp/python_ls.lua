require('lspconfig').pylsp.setup {
  on_attach = require('lsp').on_attach,
  capabilities = require('lsp').capabilities,
  settings = {
    pylsp = {
      configurationSources = { "flake8" },
      plugins = {
        flake8 = {
          enabled = true,
          filename = '.flake8'
        }
      },
      formatting = {
        provider = "flake8"
      }
    }
  }
}

