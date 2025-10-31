-- https://github.com/vscode-langservers/vscode-json-languageserver
vim.lsp.config('jsonls', {
  settings = {
    json = {
      schemas = {
        { fileMatch = { 'jsconfig.json' }, url = 'https://json.schemastore.org/jsconfig' },
        { fileMatch = { 'tsconfig.json' }, url = 'https://json.schemastore.org/tsconfig' },
        { fileMatch = { 'package.json' },  url = 'https://json.schemastore.org/package' },
      },
    },
  },
  filetypes = { "json", "jsonc", "geojson" },
})

vim.lsp.enable('html')
