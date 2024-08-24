local capabilities = require 'lsp'.capabilities
local on_attach = require 'lsp'.on_attach

local prettier = function()
  return {
    exe = "prettier",
    args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
    stdin = true,
    try_node_modules = true,
  }
end

local rustfmt = function()
  return {
    exe = "rustfmt",
    args = { "--emit=stdout" },
    stdin = true,
  }
end

local isort = function()
  print("Sorting imports...")
  return {
    exe = "isort",
    args = { "--filename", vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t"), "-" },
    stdin = true
  }
end

local flake8 = function()
  print("Formatting...")
  return {
    exe = "flake8",
  }
end

local formatter = require 'formatter'

formatter.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  logging = true,
  filetype = {
    javascript = { prettier },
    javascriptreact = { prettier },
    typescript = { prettier },
    typescriptreact = { prettier },
    css = { prettier },
    less = { prettier },
    sass = { prettier },
    scss = { prettier },
    json = { prettier },
    graphql = { prettier },
    markdown = { prettier },
    vue = { prettier },
    yaml = { prettier },
    html = { prettier },
    rust = { rustfmt },
    python = { isort } --, flake8 }
  }
})

local format_augroup = vim.api.nvim_create_augroup("format", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = format_augroup,
  callback = function()
    vim.cmd(":FormatLock")
  end,
})

-- vim.api.nvim_command [[augroup Format]]
-- vim.api.nvim_command [[autocmd! * <buffer>]]
-- vim.api.nvim_command [[autocmd BufWritePost <buffer> FormatWrite]]
-- vim.api.nvim_command [[augroup END]]
