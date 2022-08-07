local Path = require 'plenary.path'

local cmd = vim.cmd

local M = {}

function M.map(modes, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  if type(modes) == 'string' then
    modes = { modes }
  end
  for _, mode in ipairs(modes) do
    if type(rhs) == 'string' then
      vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
    else
      opts.callback = rhs
      vim.api.nvim_set_keymap(mode, lhs, '', opts)
    end
  end
end

function M.buf_map(buffer, modes, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  if type(modes) == 'string' then
    modes = { modes }
  end
  for _, mode in ipairs(modes) do
    if type(rhs) == 'string' then
      vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
    else
      opts.callback = rhs
      vim.api.nvim_buf_set_keymap(buffer, mode, lhs, '', opts)
    end
  end
end

function M.termcode(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Bust the cache of all required Lua files.
-- After running this, each require() would re-run the file.
local function unload_all_modules()
  -- Lua patterns for the modules to unload
  local unload_modules = {
    '^j.',
  }

  for k, _ in pairs(package.loaded) do
    for _, v in ipairs(unload_modules) do
      if k:match(v) then
        package.loaded[k] = nil
        break
      end
    end
  end
end

function M.reload()
  -- Stop LSP
  cmd 'LspStop'

  -- Stop eslint_d
  vim.fn.execute 'silent !pkill -9 eslint_d'

  -- Unload all already loaded modules
  unload_all_modules()

  -- Source init.lua
  cmd 'luafile $MYVIMRC'
end

-- Restart Vim without having to close and run again
function M.restart()
  -- Reload config
  M.reload()

  -- Manually run VimEnter autocmd to emulate a new run of Vim
  cmd 'doautocmd VimEnter'
end

-- Execute `PackerUpdate` every day automatically so that we are always up to
-- date!
-- I run `PackerUpdate` manually anyways, so it makes sense to run it
-- automatically.
--
-- The last saved date is saved into `XDG_CACHE_HOME/.plugins_updated_at`.
function M.update_plugins_every_day()
  local plugin_updated_at_filename = vim.env.XDG_CACHE_HOME .. '/.plugins_updated_at'
  local file = io.open(plugin_updated_at_filename)
  if not file then
    vim.fn.writefile({}, plugin_updated_at_filename)
    file:close()
  end

  local today = os.date '%Y-%m-%d'

  file = io.open(plugin_updated_at_filename)
  local contents = file:read '*a'
  if contents ~= today then
    vim.fn.execute 'PackerUpdate'

    file = io.open(plugin_updated_at_filename, 'w')
    file:write(today)
  end

  file:close()
end

function M.read_json_file(filename)
  local path = Path:new(filename)
  if not path:exists() then
    return nil
  end

  local json_contents = path:read()
  local json = vim.fn.json_decode(json_contents)

  return json
end

function M.read_package_json()
  return M.read_json_file 'package.json'
end

-- Useful function for debugging
-- Print the given items
function _G.P(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end

return M
