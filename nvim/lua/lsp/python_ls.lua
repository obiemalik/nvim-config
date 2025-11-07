-- https://jdhao.github.io/2023/07/22/neovim-pylsp-setup/

local venv_path = os.getenv('VIRTUAL_ENV')
local py_path = nil
-- decide which python executable to use for mypy
if venv_path ~= nil then
  py_path = venv_path .. "/bin/python3"
else
  -- Use 'which' to find python3 in PATH as a portable fallback
  local handle = io.popen("which python3 2>/dev/null")
  if handle then
    py_path = handle:read("*a"):gsub("%s+", "") -- trim whitespace
    handle:close()
  end
  -- If 'which' fails, try common locations
  if not py_path or py_path == "" then
    py_path = "python3" -- Let the system find it in PATH
  end
end

vim.lsp.config('pyright', {
  on_attach = function(client, bufnr)
    client.server_capabilities.renameProvider = true
    require('lsp').on_attach(client, bufnr)
  end
})
vim.lsp.enable('pyright')


