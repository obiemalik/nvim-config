-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------
local map = require('utils').keymap

-- Change leader to a comma
vim.g.mapleader = ','

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Map Esc to kk
map('i', 'kk', '<Esc>')

-- Clear search highlighting with <leader> and c
map('n', '<leader>c', ':nohl<CR>')

-- Toggle auto-indenting for code paste
map('n', '<F2>', ':set invpaste paste?<CR>')
-- DEPRECATED -- vim.opt.pastetoggle = '<F2>'

-- Change split orientation
map('n', '<leader>tk', '<C-w>t<C-w>K') -- change vertical to horizontal
map('n', '<leader>th', '<C-w>t<C-w>H') -- change horizontal to vertical

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Fast saving with <leader> and s
map('n', '<leader>s', ':w<CR>')
map('i', '<leader>s', '<C-c>:w<CR>')

-- Close all windows and exit from Neovim with <leader> and q
map('n', '<leader>q', ':qa!<CR>')

map('n', 'r<Up>', ':resize +2<CR>')
map('n', 'r<Down>', ':resize -2<CR>')
map('n', 'r<Left>', ':vertical resize -10<CR>')
map('n', 'r<Right>', ':vertical resize +10<CR>')
map('n', 'rd', ':vertical resize 85<CR>')
map('n', 'rf', ':vertical resize 140<CR>')

-- Search Panel (Spectre)
map('n', '<leader>sp', ':lua require("spectre").open()<CR>')                          -- Open
map('n', '<leader>sw', ':lua require("spectre").open_visual({select_word=true})<CR>') -- Search Current Word
map('v', '<leader>sv', ':lua require("spectre").open_visual()<CR>')
map('n', '<leader>sf', ':lua require("spectre").open_file_search()<CR>')              -- Search Current File

-- refactoring menu/prompt
map(
  "v",
  "<leader>rr",
  ":lua require('refactoring').select_refactor()<CR>",
  { noremap = true, silent = true, expr = false }
)

--map("n", "rn", ":lua vim.lsp.buf.rename()<CR>", { noremap = true })
--map("n", "rn", '<cmd>lua require("renamer").rename()<CR>', { noremap = true })        -- Rename


-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Terminal mappings
map('n', '<C-t>', ':Term<CR>', { noremap = true }) -- open
map('t', '<Esc>', '<C-\\><C-n>')                   -- exit

-- NvimTree
map('n', '<C-n>', ':NvimTreeToggle<CR>') -- open/close

-- Tagbar
-- map('n', '<leader>z', ':TagbarToggle<CR>')          -- open/close

-- Zenmode
map('n', '<leader>z', ':ZenMode<CR>')

-- Git Conflict

map('n', 'co', '<Plug>(git-conflict-ours)')
map('n', 'ct', '<Plug>(git-conflict-theirs)')
map('n', 'cb', '<Plug>(git-conflict-both)')
map('n', 'c0', '<Plug>(git-conflict-none)')
map('n', ']x', '<Plug>(git-conflict-prev-conflict)')
map('n', '[x', '<Plug>(git-conflict-next-conflict)')

map('n', '<leader>bl', ':ToggleBlameLine<CR>') -- Git Blame Line

-- Diagnostics
-- map('n', '<leader>d', ':lua vim.lsp.diagnostic.set_loclist()<CR>')
map('n', '<leader>n', ':lua vim.diagnostic.goto_next()<CR>')
map('n', '<leader>p', ':lua vim.diagnostic.goto_prev()<CR>')

-- Telescope
map('n', '<leader>ts', ':Telescope<CR>') -- Open Telescope
