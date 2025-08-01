local util = require 'lspconfig.util'

require('lspconfig').eslint.setup {
  root_dir = util.root_pattern('.eslintrc.js', '.eslintrc.cjs', '.eslintrc.json', 'eslint.config.js', 'eslint.config.mjs'),
  settings = {
    eslint = {
      -- Use default ESLint recommended rules when no config is found
      useESLintClass = true,
      -- Don't validate files without eslint config by default
      validate = 'on',
      -- Provide fallback configuration
      options = {
        overrideConfig = {
          extends = { 'eslint:recommended' },
          parserOptions = {
            ecmaVersion = 'latest',
            sourceType = 'module'
          },
          env = {
            browser = true,
            node = true,
            es6 = true
          }
        }
      },
      -- Treat missing config as warning, not error
      quiet = false,
      onIgnoredFiles = 'off'
    }
  },
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true

    require('lsp').on_attach(client, bufnr)
  end,
}
