require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "bashls",
    "cssls",
    "dockerls",
    "eslint",
    "graphql",
    "jsonls",
    "lua_ls",
    "html",
    "pylsp",
    "rust_analyzer",
    "sqlls",
    "tailwindcss",
    "tsserver",
    "yamlls"
  },
}
