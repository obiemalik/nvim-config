local neotest = require("neotest")

neotest.setup({
    adapters = {
        require("neotest-python")({
            -- pytest configuration
            dap = { justMyCode = false },
            runner = "pytest",
            -- Additional pytest args
            args = { "-v" },
        }),
    },
    -- Display test results in quickfix
    quickfix = {
        open = true,
    },
    -- Output window configuration
    output = {
        open_on_run = true,
    },
    -- Status signs
    status = {
        virtual_text = true,
        signs = true,
    },
})

-- Keybindings for Neotest
local opts = { noremap = true, silent = true }

-- Run the nearest test
vim.keymap.set("n", "<leader>tn", function()
    neotest.run.run()
end, { desc = "Run nearest test (Neotest)", noremap = true, silent = true })

-- Run the entire file
vim.keymap.set("n", "<leader>tf", function()
    neotest.run.run(vim.fn.expand("%"))
end, { desc = "Run test file (Neotest)", noremap = true, silent = true })

-- Run all tests in the project
vim.keymap.set("n", "<leader>ta", function()
    neotest.run.run(vim.uv.cwd())
end, { desc = "Run all tests (Neotest)", noremap = true, silent = true })

-- Toggle the test summary window (tree view)
vim.keymap.set("n", "<leader>ts", function()
    neotest.summary.toggle()
end, { desc = "Toggle test summary (Neotest)", noremap = true, silent = true })

-- Show test output
vim.keymap.set("n", "<leader>to", function()
    neotest.output.open({ enter = true, auto_close = true })
end, { desc = "Show test output (Neotest)", noremap = true, silent = true })

-- Stop running tests
vim.keymap.set("n", "<leader>tS", function()
    neotest.run.stop()
end, { desc = "Stop running tests (Neotest)", noremap = true, silent = true })

-- Attach to the nearest test to debug
vim.keymap.set("n", "<leader>td", function()
    neotest.run.attach()
end, { desc = "Attach to test (Neotest)", noremap = true, silent = true })
