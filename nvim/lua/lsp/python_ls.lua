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
    py_path = handle:read("*a"):gsub("%s+", "")  -- trim whitespace
    handle:close()
  end
  -- If 'which' fails, try common locations
  if not py_path or py_path == "" then
    py_path = "python3"  -- Let the system find it in PATH
  end
end

local capabilities = require 'lsp'.capabilities
local on_attach = require 'lsp'.on_attach

-- require 'lspconfig'.pylsp.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     pylsp = {
--       plugins = {
--         flake8 = {
--           enabled = true,
--           filename = '.flake8'
--         },
--         pyls_isort = {
--           enabled = true
--         },
--         pylsp_mypy = {
--           enabled = true,
--           overrides = { "--python-executable", py_path, true },
--           report_progress = true,
--           live_mode = false
--         },
--       },
--     }
--   }
-- }

require 'lspconfig'.pyright.setup {
  capabilities = capabilities,
  on_attach = on_attach
}
