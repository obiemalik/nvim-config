local status_ok, prettier = pcall(require, 'prettier')
if not status_ok then
  return
end

prettier.setup({
  bin = 'prettier',
  ['null-ls'] = {
    timeout = 2000,
  },
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    'geojson',
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
})
