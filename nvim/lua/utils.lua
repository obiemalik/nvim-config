-- Utility Functions

Utils = {}

function Utils.keymap(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end



function Utils.cmd_alias(alias, cmd, opts)
  local options = {}
  if opts ~= nil then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_create_user_command(alias, cmd, options)
end


