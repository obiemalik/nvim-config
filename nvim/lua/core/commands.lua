--- Commands
local cmd = require("utils").cmd_alias

cmd("NT", ":NvimTreeToggle")
cmd("NTR", ":NvimTreeRefresh")
cmd("NTF", ":NvimTreeFindFile")

cmd("F", ":Telescope find_files")
cmd("B", ":Telescope buffers")

-- Close NvimTree before opening Diffview (it opens in a new tab, and
-- NvimTree's tab-sync would otherwise re-open itself there asynchronously,
-- racing any autocmd-based close), then reopen it once Diffview closes.
local nvim_tree_was_open = false

cmd("DVO", function()
    local ok, tree_api = pcall(require, "nvim-tree.api")
    nvim_tree_was_open = ok and tree_api.tree.is_visible()
    if nvim_tree_was_open then
        tree_api.tree.close()
    end
    vim.cmd("DiffviewOpen")
end)

cmd("DVC", function()
    vim.cmd("DiffviewClose")
    if nvim_tree_was_open then
        local ok, tree_api = pcall(require, "nvim-tree.api")
        if ok then
            tree_api.tree.open()
        end
    end
end)

cmd("DVR", ":DiffviewRefresh")
cmd("DVF", ":DiffviewFileHistory")

cmd("VR", "vertical resize <args>", { nargs = 1 })

cmd("CopyFilePath", ":let @+=@%")
cmd("W", ":w!")
cmd("BD", "bprev | bdelete #")
cmd("C", "close")
cmd("Q", "quit")
cmd("QQ", "quitall")
