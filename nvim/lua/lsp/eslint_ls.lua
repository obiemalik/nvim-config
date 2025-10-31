local util = require 'lspconfig.util'

vim.lsp.config('eslint', {
  -- Updated root pattern to include flat config files
  root_dir = util.root_pattern(
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.json',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    'eslint.config.js',
    'eslint.config.mjs',
    'eslint.config.cjs',
    'eslint.config.ts',
    'eslint.config.mts',
    'eslint.config.cts'
  ),
  settings = {
    eslint = {
      -- Enable eslint for all supported files
      validate = 'on',
      packageManager = 'npm',
      useESLintClass = false,
      experimental = {
        useFlatConfig = true
      },
      codeActionOnSave = {
        enable = true,
        mode = "all"
      },
      format = false, -- Disable ESLint formatting, use Prettier instead
      onIgnoredFiles = 'off'
    }
  }
})

vim.lsp.enable('eslint')
