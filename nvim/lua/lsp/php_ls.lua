-- https://intelephense.com
vim.lsp.config('intelephense', {
  settings = {
    intelephense = {
      environment = {
        shortOpenTag = true
      }
    }
  }
})
vim.lsp.enable('intelephense')
