local mason = require "mason"
local mason_tool_installer = require "mason-tool-installer"
local mason_lspconfig = require "mason-lspconfig"

mason.setup {}

mason_tool_installer.setup {
  ensure_installed = {
    "mypy",
    "flake8",
    "isort",
    "prettier",
    "blackd-client"
  }
}

mason_lspconfig.setup {
  ensure_installed = {
    "bashls",
    "cssls",
    "dockerls",
    "eslint",
    "graphql",
    "jsonls",
    "ltex",
    "lua_ls",
    "html",
    "pyright",
    "rust_analyzer",
    "sqlls",
    "tailwindcss",
    "ts_ls",
    "yamlls",
  },
}
