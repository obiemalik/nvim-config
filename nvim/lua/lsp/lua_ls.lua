-- https://github.com/sumneko/lua-language-server

require('lspconfig').lua_ls.setup({
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
