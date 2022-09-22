local null_ls = require 'null-ls'

local builtins = null_ls.builtins
local sources = {
  -- builtins.formatting.eslint_d,
  -- builtins.formatting.prettierd,
  builtins.formatting.stylua,
  builtins.diagnostics.luacheck,
  builtins.code_actions.gitsigns,
}

null_ls.setup = {
  sources = sources,
  diagnostics_format = '#{m} [#{c}]',
  on_attach = require('lsp').on_attach,
}
