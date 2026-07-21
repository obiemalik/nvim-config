-- Plugin: nvim-lint
-- url: https://github.com/mfussenegger/nvim-lint

local lint = require("lint")
local langs = require("config.langs")

if langs.go then
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
end

lint.linters_by_ft = {
    javascript = { "eslint" },
    typescript = { "eslint" },
    javascriptreact = { "eslint" },
    typescriptreact = { "eslint" },
    svelte = { "eslint" },
    markdown = { "markdownlint" },
}

if langs.go then
    lint.linters_by_ft.go = { "golangci_lint" }
end

if langs.python then
    lint.linters_by_ft.python = { "mypy" }
end

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

-- Filetypes for which linting is temporarily disabled (toggled at runtime).
local disabled_ft = {}

local lintfn = function()
    if disabled_ft[vim.bo.filetype] then
        return
    end
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

-- Toggle linting on/off for a filetype (defaults to the current buffer's).
local function toggle_lint(ft)
    ft = ft ~= "" and ft or vim.bo.filetype
    if disabled_ft[ft] then
        disabled_ft[ft] = nil
        vim.notify("Linting enabled for " .. ft)
        lintfn()
    else
        disabled_ft[ft] = true
        vim.diagnostic.reset(nil, 0)
        vim.notify("Linting disabled for " .. ft)
    end
end

vim.api.nvim_create_user_command("LintToggle", function(opts)
    toggle_lint(opts.args)
end, {
    nargs = "?",
    desc = "Toggle linting for a filetype (defaults to current buffer)",
})

vim.keymap.set("n", "<leader>lt", function()
    toggle_lint("")
end, { desc = "Toggle linting for current filetype" })
