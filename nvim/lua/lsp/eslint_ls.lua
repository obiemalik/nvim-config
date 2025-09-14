local util = require 'lspconfig.util'

require('lspconfig').eslint.setup {
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
  },
  on_attach = function(client, bufnr)
    -- Disable formatting capability since we use Prettier via conform.nvim
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- Enable code actions
    if client.server_capabilities.codeActionProvider then
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {
        buffer = bufnr,
        desc = 'LSP: Code Action'
      })
    end

    -- Auto-fix ESLint issues on save
    if client.server_capabilities.codeActionProvider then
      local eslint_augroup = vim.api.nvim_create_augroup('EslintFixAll', { clear = false })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = eslint_augroup,
        buffer = bufnr,
        desc = "Auto-fix ESLint issues on save",
        callback = function()
          if vim.lsp.get_clients({ bufnr = bufnr, name = 'eslint' })[1] then
            vim.lsp.buf.code_action({
              context = { only = { 'source.fixAll.eslint' } },
              apply = true,
            })
            -- Small delay to ensure ESLint fixes are applied before formatting
            vim.defer_fn(function() end, 50)
          end
        end,
      })
    end

    require('lsp').on_attach(client, bufnr)
  end,
}
