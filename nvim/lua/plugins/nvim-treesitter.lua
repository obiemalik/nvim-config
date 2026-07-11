-----------------------------------------------------------
-- Treesitter configuration file
-----------------------------------------------------------

-- Plugin: nvim-treesitter (main branch, rewritten API)
-- url: https://github.com/nvim-treesitter/nvim-treesitter

local status_ok, nvim_treesitter = pcall(require, "nvim-treesitter")
if not status_ok then
    vim.notify("Failed to load nvim-treesitter", vim.log.levels.WARN)
    return
end

local ensure_installed = {
    "bash",
    "c",
    "cpp",
    "css",
    "go",
    "gomod",
    "gowork",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "rust",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "yaml",
}

nvim_treesitter.setup()
nvim_treesitter.install(ensure_installed)

-- jsdoc/markdown_inline/query are injected-only languages, not real filetypes
local filetypes = {
    "sh",
    "bash",
    "c",
    "cpp",
    "css",
    "go",
    "gomod",
    "gowork",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "lua",
    "markdown",
    "python",
    "rust",
    "toml",
    "typescript",
    "typescriptreact",
    "vim",
    "yaml",
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = filetypes,
    callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
