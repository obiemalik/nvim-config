-- Plugin: conform.nvim
-- url: https://github.com/stevearc/conform.nvim

local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        javascript = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        svelte = { "prettierd", "prettier" },
        css = { "prettierd", "prettier" },
        scss = { "prettierd", "prettier" },
        html = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        jsonc = { "prettierd", "prettier" },
        yaml = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
        graphql = { "prettierd", "prettier" },
        lua = { "stylua" },
        python = { "black", "ruff" },
        go = { "gofumpt", "goimports" },
        sh = { "shfmt" },
        bash = { "shfmt" },
    },
    formatters = {
        black = {
            command = function()
                -- Try activated venv first
                local venv = os.getenv("VIRTUAL_ENV")
                if venv then
                    local venv_black = venv .. "/bin/black"
                    if vim.fn.executable(venv_black) == 1 then
                        return venv_black
                    end
                end
                -- Try Poetry venv
                local root = vim.fn.getcwd()
                local poetry_venv = root .. "/.venv/bin/black"
                if vim.fn.executable(poetry_venv) == 1 then
                    return poetry_venv
                end
                -- Fall back to Mason's Black
                return "black"
            end,
            prepend_args = function()
                local root = vim.fn.getcwd()
                local config_path = root .. "/pyproject.toml"
                if vim.fn.filereadable(config_path) == 1 then
                    return { "--config", config_path }
                end
                return {}
            end,
        },
    },
    format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
        priority = 50,
    },
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
    print("Formatting...")
    conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    })
end, { desc = "Format and fix file or range (in visual mode)" })
