-- https://github.com/sumneko/lua-language-server
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
local luadev = require('lua-dev').setup {
  lspconfig = {
    on_attach = require('lsp').on_attach,
    capabilities = require('lsp').capabilities,
    settings = {
      Lua = {
        format = {
          enable = false
        }
      }
    }
  }
}

require('lspconfig').sumneko_lua.setup(luadev)
