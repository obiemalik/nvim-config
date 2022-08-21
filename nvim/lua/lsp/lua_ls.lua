-- https://github.com/sumneko/lua-language-server

require('lspconfig').sumneko_lua.setup({
  on_attach = require('lsp').on_attach,
  capabilities = require('lsp').capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})
