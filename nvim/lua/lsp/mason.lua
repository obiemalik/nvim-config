require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "eslint",
    "prettier",
    "lua_ls",
    "html",
    "pylsp",
    "rust_analyzer"
  },
}
