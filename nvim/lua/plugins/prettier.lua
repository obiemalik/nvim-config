local status_ok, prettier = pcall(require, 'prettier')
if not status_ok then
  return
end

prettier.setup({
  bin = 'prettier',
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    'geojson',
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
})


-- local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- autocmd('BufWritePre', {
--   pattern = { '*.json', "*.md", "*.html", "*.css" },
--   callback = function()
--     vim.cmd('Prettier')
--   end,
-- })

-- autocmd('BufWritePre', {
--   pattern = { '*.ts', '*.tsx', '*.js', '*.jsx', '*.mjs', '*.cjs' },
--   callback = function()
--     vim.cmd('EslintFixAll')
--     vim.cmd('Prettier')
--   end,
-- })

-- local function cmdOnSave(cmd, filename, options)
--   options = options or {}
--   local silent = options.silent or false
--
--   -- Start the command asynchronously
--   local job_id = vim.fn.jobstart(cmd, {
--     cwd = vim.fn.getcwd(),
--     on_exit = function(job_id, exit_code)
--       if exit_code == 0 then
--         -- cmd completed successfully; reload file quietly
--         vim.cmd("silent edit " .. filename)
--         if not silent then
--           print("[" .. job_id .. "][" .. filename .. "] Cmd completed and buffer saved.")
--         end
--       else
--         -- Encountered an error, print a message
--         print("Encountered an error. Buffer not saved.")
--       end
--     end,
--   })
--
--   -- Wait until the command is done
--   vim.fn.jobwait({ job_id }, -1)
-- end

-- autocmd('BufWritePost', {
--   pattern = { '*.ts', '*.tsx', '*.js', '*.jsx', '*.mjs', '*.cjs' },
--   callback = function()
--     vim.cmd('EslintFixAll')
--
--     local bufnr = vim.fn.bufnr()
--     local filename = vim.api.nvim_buf_get_name(bufnr)
--
--     cmdOnSave("prettier --write " .. filename, filename, { silent = true })
--     -- cmdOnSave("eslint --fix " .. filename, filename, { silent = true })
--   end
-- })
