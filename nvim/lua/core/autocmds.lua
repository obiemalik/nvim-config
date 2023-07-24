local async = require('plenary.async')

-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
  end
})

-- Remove whitespace on save
autocmd('BufWritePre', {
  pattern = '*',
  command = ":%s/\\s\\+$//e"
})

-- Don't auto commenting new lines
autocmd('BufEnter', {
  pattern = '*',
  command = 'set fo-=c fo-=r fo-=o'
})

-- Settings for filetypes:
-- Disable line length marker
augroup('setLineLength', { clear = true })
autocmd('Filetype', {
  group = 'setLineLength',
  pattern = { 'text', 'markdown', 'html', 'xhtml', 'python' },
  command = 'setlocal cc=0'
})

-- Set indentation to 2 spaces
augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
    'yaml', 'lua'
  },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

-- Terminal settings:
-- Open a Terminal on the right tab
autocmd('CmdlineEnter', {
  command = 'command! Term :botright vsplit term://$SHELL'
})

-- Enter insert mode when switching to terminal
autocmd('TermOpen', {
  command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})

autocmd('TermOpen', {
  pattern = '*',
  command = 'startinsert'
})

-- Close terminal buffer on process exit
autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert'
})

-- Show Diagnostics or Documenation on Hover
autocmd({ 'CursorHold', 'CursorHoldI' }, {
  callback = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local diagnostic = vim.diagnostic.get(0, { lnum = cursor[1] - 1 })

    -- Only show diagnostic if cursor is over the artifact
    -- TODO: Show diagnostic for artifact under cursor only, not all line diagnostics
    local isUnderCursor = false
    if (#diagnostic > 0) then
      for i = 1, #diagnostic do
        if isUnderCursor == false then
          if diagnostic[i].end_lnum ~= diagnostic[i].lnum then
            -- if multiline diagnostic, show only on few characters of first line
            isUnderCursor = cursor[2] > diagnostic[i].col - 2 and cursor[2] < diagnostic[i].col + 2
          else
            if math.abs(diagnostic[i].end_col - diagnostic[i].col) < 2 then
              isUnderCursor = cursor[2] > diagnostic[i].col - 2 and cursor[2] < diagnostic[i].end_col + 2
            else
              isUnderCursor = cursor[2] > diagnostic[i].col - 1 and cursor[2] < diagnostic[i].end_col
            end
          end
        end
      end
    end

    if (#diagnostic > 0 and isUnderCursor) then
      vim.diagnostic.open_float();
    else
      vim.cmd('silent! lua vim.lsp.buf.hover()')
    end
  end
})

autocmd('BufWritePre', {
  pattern = { '*.json', "*.md", "*.html", "*.css" },
  callback = function()
    vim.cmd('Prettier')
  end,
})

-- autocmd('BufWritePre', {
--   pattern = { '*.ts', '*.tsx', '*.js', '*.jsx', '*.mjs', '*.cjs' },
--   callback = function()
--     vim.cmd('EslintFixAll')
--     vim.cmd('Prettier')
--   end,
-- })

local function cmdOnSave(cmd, filename, options)
  options = options or {}
  local silent = options.silent or false

  -- Start the command asynchronously
  local job_id = vim.fn.jobstart(cmd, {
    cwd = vim.fn.getcwd(),
    on_exit = function(job_id, exit_code)
      if exit_code == 0 then
        -- cmd completed successfully; reload file quietly
        vim.cmd("silent edit " .. filename)
        if not silent then
          print("[" .. job_id .. "][" .. filename .. "] Cmd completed and buffer saved.")
        end
      else
        -- Encountered an error, print a message
        print("Encountered an error. Buffer not saved.")
      end
    end,
  })

  -- Wait until the command is done
  vim.fn.jobwait({ job_id }, -1)
end

autocmd('BufWritePost', {
  pattern = { '*.ts', '*.tsx', '*.js', '*.jsx', '*.mjs', '*.cjs' },
  callback = function()
    vim.cmd('EslintFixAll')

    local bufnr = vim.fn.bufnr()
    local filename = vim.api.nvim_buf_get_name(bufnr)

    cmdOnSave("prettier --write " .. filename, filename, { silent = true })
    -- cmdOnSave("eslint --fix " .. filename, filename, { silent = true })
  end
})
