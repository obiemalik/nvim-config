-- https://github.com/sumneko/lua-language-server

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            -- lazydev.nvim injects the Neovim runtime/plugin libraries per-buffer;
            -- let it own that instead of lua_ls's own third-party heuristics.
            workspace = {
                checkThirdParty = false,
            },
        },
    },
})

vim.lsp.enable("lua_ls")
