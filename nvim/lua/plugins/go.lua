-- Go-specific configuration and key mappings
local map = require('utils').map

-- Go-specific autocommands
vim.api.nvim_create_augroup('GoAutocommands', { clear = true })

-- Set Go-specific options
vim.api.nvim_create_autocmd('FileType', {
  group = 'GoAutocommands',
  pattern = 'go',
  callback = function()
    -- Use tabs for Go files (Go convention)
    vim.bo.expandtab = false
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    
    -- Set comment string for Go
    vim.bo.commentstring = '// %s'
    
    -- Enable spell checking for comments
    vim.wo.spell = true
    vim.bo.spellcapcheck = ''
  end,
})

-- Go-specific key mappings (only active in Go files)
vim.api.nvim_create_autocmd('FileType', {
  group = 'GoAutocommands',
  pattern = 'go',
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local opts = { buffer = buf, silent = true }
    
    -- Go build and run
    vim.keymap.set('n', '<leader>gb', ':GoBuild<CR>', opts)
    vim.keymap.set('n', '<leader>gr', ':GoRun<CR>', opts)
    vim.keymap.set('n', '<leader>gt', ':GoTest<CR>', opts)
    vim.keymap.set('n', '<leader>gT', ':GoTestFunc<CR>', opts)
    vim.keymap.set('n', '<leader>gc', ':GoCoverage<CR>', opts)
    vim.keymap.set('n', '<leader>gC', ':GoCoverageToggle<CR>', opts)
    
    -- Go generate and mod
    vim.keymap.set('n', '<leader>gg', ':GoGenerate<CR>', opts)
    vim.keymap.set('n', '<leader>gm', ':GoMod<CR>', opts)
    
    -- Go doc and imports
    vim.keymap.set('n', '<leader>gd', ':GoDoc<CR>', opts)
    vim.keymap.set('n', '<leader>gi', ':GoImports<CR>', opts)
    
    -- Go tags
    vim.keymap.set('n', '<leader>gj', ':GoAddTags json<CR>', opts)
    vim.keymap.set('n', '<leader>gJ', ':GoRemoveTags json<CR>', opts)
    
    -- Go alternate (switch between file and test)
    vim.keymap.set('n', '<leader>ga', ':GoAlternate<CR>', opts)
    
    -- Go struct tags
    vim.keymap.set('v', '<leader>gj', ':GoAddTags json<CR>', opts)
    vim.keymap.set('v', '<leader>gJ', ':GoRemoveTags json<CR>', opts)
    
    -- Go interface implementation
    vim.keymap.set('n', '<leader>gI', ':GoImpl<CR>', opts)
    
    -- Go rename
    vim.keymap.set('n', '<leader>gR', ':GoRename<CR>', opts)
    
    -- Go fill struct
    vim.keymap.set('n', '<leader>gf', ':GoFillStruct<CR>', opts)
    
    -- Go keyify
    vim.keymap.set('n', '<leader>gk', ':GoKeyify<CR>', opts)
    
    -- Go if err snippet
    vim.keymap.set('i', '<C-e>', '<Esc>:GoIfErr<CR>i', opts)
  end,
})

-- Go test output settings
vim.api.nvim_create_autocmd('FileType', {
  group = 'GoAutocommands',
  pattern = 'go',
  callback = function()
    -- Set up test output formatting
    vim.g.go_test_show_name = 1
    vim.g.go_test_timeout = '10s'
    vim.g.go_test_prepend_name = 1
  end,
})

-- Go debugging settings (if using delve)
vim.api.nvim_create_autocmd('FileType', {
  group = 'GoAutocommands',
  pattern = 'go',
  callback = function()
    -- Debugging key mappings
    local buf = vim.api.nvim_get_current_buf()
    local opts = { buffer = buf, silent = true }
    
    -- Debug commands
    vim.keymap.set('n', '<leader>db', ':GoDebugBreakpoint<CR>', opts)
    vim.keymap.set('n', '<leader>dt', ':GoDebugTest<CR>', opts)
    vim.keymap.set('n', '<leader>ds', ':GoDebugStart<CR>', opts)
    vim.keymap.set('n', '<leader>dS', ':GoDebugStop<CR>', opts)
  end,
})

-- Auto-format Go files on save (handled by conform.nvim)
vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'GoAutocommands',
  pattern = '*.go',
  callback = function()
    -- This is handled by conform.nvim, but we can add Go-specific logic here if needed
    vim.lsp.buf.code_action({
      context = { only = { 'source.organizeImports' } },
      apply = true,
    })
  end,
})

-- Highlight Go test functions
vim.api.nvim_create_autocmd('FileType', {
  group = 'GoAutocommands',
  pattern = 'go',
  callback = function()
    -- Highlight test functions
    vim.fn.matchadd('Function', 'func Test\\w\\+')
    vim.fn.matchadd('Function', 'func Benchmark\\w\\+')
    vim.fn.matchadd('Function', 'func Example\\w\\+')
  end,
})

-- Go-specific abbreviations
vim.api.nvim_create_autocmd('FileType', {
  group = 'GoAutocommands',
  pattern = 'go',
  callback = function()
    -- Common Go abbreviations
    vim.cmd('iabbrev <buffer> iff if err != nil {<CR>return err<CR>}')
    vim.cmd('iabbrev <buffer> iferr if err != nil {<CR>return err<CR>}')
    vim.cmd('iabbrev <buffer> ifn if err != nil {<CR>return nil, err<CR>}')
    vim.cmd('iabbrev <buffer> prt fmt.Printf("")<Left><Left>')
    vim.cmd('iabbrev <buffer> prl fmt.Println("")<Left><Left>')
    vim.cmd('iabbrev <buffer> prn fmt.Printf("\\n")')
  end,
})

-- Go mod tidy on save
vim.api.nvim_create_autocmd('BufWritePost', {
  group = 'GoAutocommands',
  pattern = 'go.mod',
  callback = function()
    vim.cmd('silent! !go mod tidy')
  end,
})

-- Go build tags detection
vim.api.nvim_create_autocmd('FileType', {
  group = 'GoAutocommands',
  pattern = 'go',
  callback = function()
    -- Detect build tags and set syntax highlighting
    local lines = vim.api.nvim_buf_get_lines(0, 0, 10, false)
    for _, line in ipairs(lines) do
      if line:match('^//go:build') or line:match('^// +build') then
        vim.fn.matchadd('PreProc', line)
        break
      end
    end
  end,
})
