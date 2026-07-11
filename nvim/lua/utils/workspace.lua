local Workspace = {}
local map = require("utils").map

Workspace.is_local_workspace = false -- true = local project / false = root workspace

local markers = {
    "package.json",
    "go.mod",
    "Cargo.toml",
    "composer.json",
    "pyproject.toml",
    "Makefile",
    ".git", -- Fallback to workspace root if no other marker found
}

function Workspace.get_workspace_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    if dot_git_path ~= "" then
        return vim.fn.fnamemodify(dot_git_path, ":h")
    end
    return vim.loop.cwd()
end

function Workspace.get_project_root()
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_dir
    if current_file == "" then
        current_dir = vim.loop.cwd()
    else
        current_dir = vim.fn.fnamemodify(current_file, ":h")
    end

    local root = vim.fs.find(markers, {
        path = current_dir,
        upward = true,
        stop = vim.loop.os_homedir(),
        limit = 1,
    })[1]

    if root then
        return vim.fs.dirname(root)
    end

    return current_dir
end

function Workspace.get_current()
    return Workspace.is_local_workspace and Workspace.get_project_root()
        or Workspace.get_workspace_root()
end

function Workspace.toggle_scope()
    Workspace.is_local_workspace = not Workspace.is_local_workspace
    local scope = Workspace.is_local_workspace and "Project (Sub-package)"
        or "Workspace (Monorepo)"
    vim.notify(
        string.format("Telescope Scope: %s %s", scope, Workspace.get_current()),
        vim.log.levels.INFO
    )
    vim.cmd("redrawstatus")
end

map("n", "<leader>tw", Workspace.toggle_scope)

return Workspace
