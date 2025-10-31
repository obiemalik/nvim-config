-- https://github.com/valentjn/ltex-ls
vim.lsp.config('ltex', {
  settings = {
    ltex = {
      disabledRules = {
        ['en-US'] = { "WHITESPACE_RULE" }
      }
    }
  }
})

vim.lsp.enable('ltex')
