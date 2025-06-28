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

-- Set up mason-lspconfig settings to prevent automatic enable issues
require("mason-lspconfig.settings").set({
  automatic_enable = false
})

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
  -- Install servers automatically but don't set them up automatically
  automatic_installation = true,
  automatic_setup = false,
}
