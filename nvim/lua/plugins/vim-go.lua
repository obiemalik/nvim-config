-- Plugin: vim-go
-- url: https://github.com/fatih/vim-go

-- Disable vim-go LSP features since we're using gopls through nvim-lspconfig
vim.g.go_def_mapping_enabled = 0
vim.g.go_doc_keywordprg_enabled = 0
vim.g.go_code_completion_enabled = 0
vim.g.go_gopls_enabled = 0

-- Enable useful vim-go features
vim.g.go_fmt_autosave = 0 -- We handle formatting through conform.nvim
vim.g.go_imports_autosave = 0 -- We handle imports through conform.nvim
vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_build_constraints = 1
vim.g.go_highlight_generate_tags = 1

-- Test settings
vim.g.go_test_show_name = 1
vim.g.go_test_timeout = "10s"

-- Template settings
vim.g.go_template_autocreate = 1
