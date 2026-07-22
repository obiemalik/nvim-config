local status_ok, claudecode = pcall(require, "claudecode")
if not status_ok then
    return
end

claudecode.setup()

local map = require("utils").map

-- Claude terminal's job/buffer persists in the background once created
-- (native provider sets bufhidden=hide), so hiding it here never kills
-- the session; reopening reattaches to the same one.
local function claude_win()
    local bufnr = require("claudecode.terminal").get_active_terminal_bufnr()
    if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
        return nil, bufnr
    end
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == bufnr then
            return win, bufnr
        end
    end
    return nil, bufnr
end

-- Toggle the pinned Claude Code split (right side, terminal.split_side default).
local function claude_toggle()
    local win = claude_win()
    if win then
        if #vim.api.nvim_list_wins() > 1 then
            vim.api.nvim_win_close(win, false)
        else
            -- Sole window left: can't close it, so swap in a scratch buffer
            -- instead; bufhidden=hide keeps the job alive in the background.
            vim.api.nvim_win_set_buf(win, vim.api.nvim_create_buf(false, true))
        end
        return
    end
    require("claudecode.terminal").open()
end

-- Focus the pinned split, opening it first if it isn't there.
local function claude_focus()
    local win = claude_win()
    if win then
        vim.api.nvim_set_current_win(win)
        vim.cmd("startinsert")
        return
    end
    require("claudecode.terminal").open()
end

map("n", "<leader>ac", claude_toggle)
map("n", "<leader>af", claude_focus)
map("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>")
map("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>")
map("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>")

-- Auto-zoom: whenever the Claude terminal (or its inline diff view) is
-- focused, close NvimTree and blow the current window up to fill the tab;
-- leaving it restores the exact prior window sizes and NvimTree. Classic
-- `winrestcmd()` zoom-toggle idiom, no plugin needed.
local claude_group = vim.api.nvim_create_augroup("ClaudeCodeZoom", { clear = true })
local restore_cmd = nil
local tree_was_open = false

local function is_claude_buf(buf)
    local ok, bufnr = pcall(function()
        return require("claudecode.terminal").get_active_terminal_bufnr()
    end)
    return ok and bufnr == buf
end

local function zoom_in()
    if restore_cmd then
        return
    end
    restore_cmd = vim.fn.winrestcmd()
    local ok, tree_api = pcall(require, "nvim-tree.api")
    tree_was_open = ok and tree_api.tree.is_visible()
    if tree_was_open then
        tree_api.tree.close()
    end
    vim.cmd("resize 9999")
    vim.cmd("vertical resize 9999")
end

local function zoom_out()
    if not restore_cmd then
        return
    end
    vim.cmd(restore_cmd)
    restore_cmd = nil
    if tree_was_open then
        local ok, tree_api = pcall(require, "nvim-tree.api")
        if ok then
            tree_api.tree.open()
        end
    end
end

vim.api.nvim_create_autocmd("BufEnter", {
    group = claude_group,
    callback = function(args)
        if is_claude_buf(args.buf) then
            zoom_in()
        end
    end,
})

vim.api.nvim_create_autocmd("BufLeave", {
    group = claude_group,
    callback = function(args)
        if is_claude_buf(args.buf) then
            zoom_out()
        end
    end,
})

vim.api.nvim_create_autocmd("User", {
    group = claude_group,
    pattern = "ClaudeCodeDiffOpened",
    callback = zoom_in,
})

vim.api.nvim_create_autocmd("User", {
    group = claude_group,
    pattern = "ClaudeCodeDiffClosed",
    callback = zoom_out,
})

-- Keep the Claude terminal out of the bufferline entirely, it's a pinned
-- utility window, not a file buffer to tab through.
vim.api.nvim_create_autocmd("TermOpen", {
    group = claude_group,
    callback = function(args)
        local buf = args.buf
        vim.schedule(function()
            if vim.api.nvim_buf_is_valid(buf) and is_claude_buf(buf) then
                vim.bo[buf].buflisted = false
            end
        end)
    end,
})