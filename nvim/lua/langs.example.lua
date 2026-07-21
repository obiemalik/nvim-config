-- Machine-local language configuration.
-- Copy langs.example.lua to this file and adjust for this machine.
-- Controls which language toolchains Mason installs and which LSP/lint/format
-- configs are activated.
--
-- If this file is absent, each language falls back to auto-detecting whether
-- the relevant executable is on PATH (go, python3, node).

return {
    go = true, -- gopls, gofumpt, goimports, golines, golangci-lint, staticcheck…
    python = true, -- pyright, black, mypy, isort
    javascript = true, -- tsc_native, eslint, prettier
    typescript = true, -- tsc_native, eslint, prettier
}
