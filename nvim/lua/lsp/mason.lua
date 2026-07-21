local mason = require("mason")
local mason_tool_installer = require("mason-tool-installer")
local mason_lspconfig = require("mason-lspconfig")

local langs = require("config.langs")

mason.setup({})

local tools = { "prettier" }

if langs.go then
    vim.list_extend(
        tools,
        {
            "gofumpt",
            "goimports",
            "golines",
            "golangci-lint",
            "gotests",
            "impl",
            "staticcheck",
        }
    )
end

if langs.python then
    vim.list_extend(tools, { "mypy", "isort", "black" })
end

mason_tool_installer.setup({ ensure_installed = tools })

-- Set up mason-lspconfig settings to prevent automatic enable issues
require("mason-lspconfig.settings").set({
    automatic_enable = false,
})

local lsp_servers = {
    "bashls",
    "cssls",
    "dockerls",
    "eslint",
    "graphql",
    "jsonls",
    "ltex",
    "lua_ls",
    "html",
    "rust_analyzer",
    "sqlls",
    "tailwindcss",
    "yamlls",
}

if langs.go then
    vim.list_extend(lsp_servers, { "gopls" })
end

if langs.python then
    vim.list_extend(lsp_servers, { "pyright" })
end

mason_lspconfig.setup({
    ensure_installed = lsp_servers,
    -- Install servers automatically but don't set them up automatically
    automatic_installation = true,
    automatic_setup = false,
})
