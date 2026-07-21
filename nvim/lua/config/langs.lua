-- Centralized language-toolchain flags.
-- Load user overrides from langs.lua (gitignored, machine-local).
-- Fall back to auto-detecting installed executables when the file is absent.

local ok, user = pcall(require, "langs")

local function detect(exe)
    return vim.fn.executable(exe) == 1
end

local defaults = {
    go = detect("go"),
    python = detect("python3"),
    javascript = detect("node"),
    typescript = detect("node"),
}

-- User file wins over auto-detection; auto-detection wins over nothing.
return ok and vim.tbl_extend("force", defaults, user) or defaults
