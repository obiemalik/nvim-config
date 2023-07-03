require("mason").setup()
require("mason-lspconfig").setup {
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
    "pylsp",
    "sqlls",
    "tailwindcss",
    "tsserver",
    "yamlls"
  },
}
