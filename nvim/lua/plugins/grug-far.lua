-- Plugin: grug-far.nvim
-- url: https://github.com/MagicDuck/grug-far.nvim

require("grug-far").setup()

local M = {}

-- Open with the visually-selected text prefilled as the search term
function M.open_visual()
    local grug_far = require("grug-far")
    local s_start = vim.fn.getpos("'<")
    local s_end = vim.fn.getpos("'>")
    local lines = vim.fn.getline(s_start[2], s_end[2])
    if #lines == 0 then
        grug_far.open()
        return
    end
    lines[#lines] = string.sub(lines[#lines], 1, s_end[3])
    lines[1] = string.sub(lines[1], s_start[3])
    grug_far.open({ prefills = { search = table.concat(lines, "\n") } })
end

return M
