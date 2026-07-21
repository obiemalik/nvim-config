if not require("config.langs").typescript then
    return
end

-- Define configuration for TypeScript 7 native compiler
vim.lsp.config("tsc_native", {
    cmd = { "tsc", "--lsp", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
    },
    root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", ".git" }),
    settings = {
        typescript = {
            inlayHints = {
                parameterNames = { enabled = "all" },
            },
        },
    },
})

-- Enable the server
vim.lsp.enable("tsc_native")
