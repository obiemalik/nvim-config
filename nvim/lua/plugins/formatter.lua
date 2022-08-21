local status_ok, formatter = pcall(require, 'formatter')
if not status_ok then
  print('Formatter not found.')
  return
end

local prettier = function()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
    stdin = true,
    try_node_modules = true,
  }
end

local rustfmt = function()
  return {
    exe = "rustfmt",
    args = {"--emit=stdout"},
    stdin = true,
  }
end

formatter.setup({
  logging = true,
  filetype = {
    javascript = {prettier},
    javascriptreact = {prettier},
    typescript = {prettier},
    typescriptreact = {prettier},
    css = {prettier},
    less = {prettier},
    sass = {prettier},
    scss = {prettier},
    json = {prettier},
    graphql = {prettier},
    markdown = {prettier},
    vue = {prettier},
    yaml = {prettier},
    html = {prettier},
    rust = {rustfmt},
  },
})

-- vim.api.nvim_command [[augroup Format]]
-- vim.api.nvim_command [[autocmd! * <buffer>]]
-- vim.api.nvim_command [[autocmd BufWritePost <buffer> FormatWrite]]
-- vim.api.nvim_command [[augroup END]]

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html,*.rs FormatWrite
augroup END
]], true)
