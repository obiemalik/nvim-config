-- Plugin: lazydev.nvim
-- url: https://github.com/folke/lazydev.nvim
--
-- Gives lua_ls full type information for the Neovim runtime API and
-- installed plugins (replaces the never-configured folke/lua-dev.nvim).

require("lazydev").setup({
    library = {
        -- Loads the `vim.uv` types when required
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
})
