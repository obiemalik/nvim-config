-- Plugin: nvim-lint
-- url: https://github.com/mfussenegger/nvim-lint

local lint = require("lint")

-- Configure golangci-lint to use Mason-installed binary
local function find_golangci_lint()
    local mason_path =
        vim.fn.expand("~/.local/share/nvim/mason/packages/golangci-lint")
    local handle = io.popen(
        "find "
            .. mason_path
            .. " -name 'golangci-lint' -type f 2>/dev/null | head -1"
    )
    local result = handle:read("*a")
    handle:close()
    return result:gsub("\n", "")
end

lint.linters.golangci_lint = {
    cmd = find_golangci_lint(),
    stdin = false,
    args = {
        "run",
        "--out-format",
        "json",
        "--show-stats=false",
        "--print-issued-lines=false",
        "--print-linter-name=false",
        "--path-prefix",
        function()
            return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
        end,
    },
    ignore_exitcode = true,
    parser = function(output)
        local results = {}
        local ok, decoded = pcall(vim.json.decode, output)
        if not ok then
            return results
        end

        if decoded.Issues then
            for _, issue in ipairs(decoded.Issues) do
                table.insert(results, {
                    lnum = issue.Pos.Line - 1,
                    col = issue.Pos.Column - 1,
                    message = issue.Text,
                    severity = vim.diagnostic.severity.WARN,
                    source = "golangci-lint",
                    code = issue.FromLinter,
                })
            end
        end
        return results
    end,
}

lint.linters_by_ft = {
    javascript = { "eslint" },
    typescript = { "eslint" },
    javascriptreact = { "eslint" },
    typescriptreact = { "eslint" },
    svelte = { "eslint" },
    python = { "mypy" },
    go = { "golangci_lint" },
    markdown = { "markdownlint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
local lintfn = function()
    lint.try_lint()
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = lintfn,
})

vim.keymap.set(
    "n",
    "<leader>l",
    lintfn,
    { desc = "Trigger linting for current file" }
)
