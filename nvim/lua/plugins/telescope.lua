local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("telescope.builtin")
local workspace = require("utils.workspace")

-- Switching windows normally fires telescope's BufLeave-on-prompt autocmd,
-- which closes the whole picker. `noautocmd` sidesteps that so we can hop
-- into the preview window and back. See:
-- https://github.com/nvim-telescope/telescope.nvim/issues/2778
local function focus_preview(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local prompt_win = picker.prompt_win
    local previewer = picker.previewer
    if not (previewer and previewer.state and previewer.state.winid) then
        return
    end
    local preview_win = previewer.state.winid
    local preview_bufnr = previewer.state.bufnr

    vim.keymap.set("n", "<C-p>", function()
        vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%d)", prompt_win))
        vim.cmd("startinsert")
    end, { buffer = preview_bufnr })

    vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%d)", preview_win))
end

local map = require("utils").map

-- Telescope

-- Scoped Finders
-- Calls helpers via functions instead of builtins, otherwise the initial setup
-- freezes the scope instead of reevaluating on call

local function find_files_smart()
    builtin.find_files({ cwd = workspace.get_current() })
end

local function live_grep_smart()
    builtin.live_grep({ cwd = workspace.get_current() })
end

local function grep_string_smart()
    builtin.grep_string({ cwd = workspace.get_current() })
end

map("n", "<leader>ff", find_files_smart)
map("n", "<leader>fg", live_grep_smart)
map("n", "<leader>fs", grep_string_smart)

map("n", "<leader>fb", builtin.buffers)
map("n", "<leader>fh", builtin.help_tags)
map("n", "<leader>fo", builtin.oldfiles)
map("n", "<leader>fq", builtin.quickfix)
map("n", "<leader>fx", builtin.git_status)
map("n", "<leader>fc", builtin.git_commits)
map("n", "<leader>fB", builtin.git_branches)

require("telescope").setup({
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        prompt_prefix = " ❯ ",
        selection_caret = "❯ ",
        mappings = {
            i = {
                ["<Esc>"] = actions.close,

                ["<c-j>"] = actions.move_selection_next,
                ["<c-k>"] = actions.move_selection_previous,

                ["<s-up>"] = actions.cycle_history_prev,
                ["<s-down>"] = actions.cycle_history_next,

                ["<c-x>"] = actions.delete_buffer,
                ["<C-f>"] = actions.preview_scrolling_down,
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-p>"] = focus_preview,

                ["<C-w>"] = function()
                    vim.api.nvim_input("<c-s-w>")
                end,
            },
            n = {
                ["<Esc>"] = actions.close,
            },
        },
        file_ignore_patterns = { "node_modules", ".git" },
        path_display = { "absolute", truncate = true },
        dynamic_preview_title = true,
        preview = {
            treesitter = false,
            hide_on_startup = false,
        },
        layout_strategy = "vertical",
        layout_config = {
            vertical = {
                preview_height = 0.5,
                preview_cutoff = 10,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
        },
    },
    pickers = {
        oldfiles = {
            sort_lastused = true,
            cwd_only = true,
        },
        buffers = {
            sort_lastused = true,
        },
        find_files = {
            hidden = false,
            path_display = { "absolute", truncate = true },
        },
        live_grep = {
            path_display = { "absolute", truncate = true },
        },
    },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
