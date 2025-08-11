-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------
-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim
-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme
-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' ..
      vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost packer_init.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

packer.init({
  git = {
    clone_timeout = 120,
  },
  max_jobs = 10
})

-- Install plugins
return packer.startup(function(use)
  use { 'wbthomason/packer.nvim' }

  -- UI --
  use { 'kyazdani42/nvim-tree.lua', -- File explorer
    config = function()
      require('plugins/nvim-tree')
    end
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  }
  use { -- Telescope (Fuzzy File Search)
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    requires = {
      { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
  }

  use { 'nvim-pack/nvim-spectre' } -- Search/Replace Panel
  use { 'preservim/tagbar' }       -- Tag viewer
  use {                            -- Bufferline
    'akinsho/bufferline.nvim',
    tag = "*",
    requires = 'nvim-tree/nvim-web-devicons'
  }
  use { 'feline-nvim/feline.nvim' } -- Statusline
  use { 'goolord/alpha-nvim' }      -- Dashboard (start screen)
  use { 'folke/zen-mode.nvim' }     -- Zen Mode

  -- Color schemes --

  use { 'NLKNguyen/papercolor-theme' }
  use { 'navarasu/onedark.nvim' }
  use { 'tanvirtin/monokai.nvim' }
  use { "catppuccin/nvim", as = "catppuccin" }
  use { "miikanissi/modus-themes.nvim" }
  use { "bluz71/vim-moonfly-colors", as = "moonfly" }

  use { -- Keybinding Popup
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end,
  }

  -- GIT --

  use { -- Git Diffview
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }
  use { -- Git Conflict
    'akinsho/git-conflict.nvim',
    config = function()
      require('git-conflict').setup()
    end,
  }
  use {
    'tveskag/nvim-blame-line'
  }

  -- EDITOR --

  use { 'airblade/vim-rooter' } -- Root Workspace to Project
  use {                         -- GIT Labels
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end,
  }
  use { -- Comments
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  }

  use { -- Peek Goto Line
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup()
    end,
  }

  use { -- Highlight TODO/FIXME/...
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('todo-comments').setup()
    end,
  }
  use { -- NPM Package Info
    'vuki656/package-info.nvim',
    requires = 'MunifTanjim/nui.nvim',
    config = function()
      require('package-info').setup()
    end,
  }

  use { -- Markdown Preview
    'iamcco/markdown-preview.nvim',
    run = 'cd app && npm install',
    setup = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  }

  use { -- Surround Code Blocks
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end,
  }
  use { -- Autopair
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  }
  use { -- Render HEX Colors
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  }
  use { "lukas-reineke/indent-blankline.nvim" } -- Show Indent Markers

  -- Treesitter (Code Highlighting)
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('plugins/nvim-treesitter')
    end,
    requires = {
      'windwp/nvim-ts-autotag', -- Automatically end & rename tags
      'nvim-treesitter/playground',
    },
  }

  -- Dynamically set commentstring based on cursor location in file
  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('ts_context_commentstring').setup()
    end,
    before = { "nvim-treesitter" }
  }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = { 'nvim-treesitter' },
  }
  use {
    'RRethy/nvim-treesitter-textsubjects',
    after = { 'nvim-treesitter' },
  }

  use {
    'm-demare/hlargs.nvim',
    config = function()
      require('hlargs').setup()
    end,
  }

  use {
    "ThePrimeagen/refactoring.nvim", -- Refactor
    requires = { { "nvim-lua/plenary.nvim" }, { "nvim-treesitter/nvim-treesitter" } },
  }

  use { 'gbprod/stay-in-place.nvim' } -- Fix Indent Cursor Position
  use { 'AndrewRadev/splitjoin.vim' } -- Spread code-block

  use {
    'lewis6991/hover.nvim',
    config = function()
      require('hover').setup {
        init = function()
          -- Require providers
          require('hover.providers.lsp')
          -- require('hover.providers.gh')
          -- require('hover.providers.man')
          -- require('hover.providers.dictionary')
        end,
        preview_opts = {
          border = nil,
        },
        title = true,
      }

      -- Setup keymaps
      vim.keymap.set('n', 'K', require('hover').hover, {
        desc = 'hover.nvim',
      })
      vim.keymap.set('n', 'gK', require('hover').hover_select, {
        desc = 'hover.nvim (select)',
      })
    end,
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig', -- Built-in LSP configurations
    config = function()
      require 'lsp.mason'
      require 'lsp'
      require 'lsp.bash_ls'
      require 'lsp.css_ls'
      require 'lsp.docker_ls'
      require 'lsp.graphql_ls'
      require 'lsp.json_ls'
      require 'lsp.php_ls'
      require 'lsp.ts_ls'
      require 'lsp.eslint_ls'
      require 'lsp.yaml_ls'
      require 'lsp.lua_ls'
      require 'lsp.terraform_ls'
      require 'lsp.haskell_ls'
      require 'lsp.ltex_ls'
      require 'lsp.prisma_ls'
      require 'lsp.html_ls'
      require 'lsp.svelte_ls'
      require 'lsp.tailwind_ls'
      require 'lsp.python_ls'
      require 'lsp.rust_ls'
      require 'lsp.go_ls'
    end,
    requires = {
      {
        'hrsh7th/nvim-cmp',
        requires = {
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-path',
          'saadparwaiz1/cmp_luasnip',
          'petertriho/cmp-git',
        },
        config = function()
          require 'plugins.cmp'
        end,
      },
      'folke/lua-dev.nvim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      --
      -- require 'plugins.nvim-lint',
      -- require 'plugins.conform'
    },
    run = ':MasonUpdate',
  }

  use { 'MunifTanjim/prettier.nvim', config = function() require 'plugins.prettier' end }

  -- use { unpack(require 'plugins.nvim-lint') }

  use {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      -- Configure golangci-lint to use Mason-installed binary
      local function find_golangci_lint()
        local mason_path = vim.fn.expand("~/.local/share/nvim/mason/packages/golangci-lint")
        local handle = io.popen("find " .. mason_path .. " -name 'golangci-lint' -type f 2>/dev/null | head -1")
        local result = handle:read("*a")
        handle:close()
        return result:gsub("\n", "")
      end

      lint.linters.golangci_lint = {
        cmd = find_golangci_lint(),
        stdin = false,
        args = {
          "run",
          "--out-format",
          "json",
          "--show-stats=false",
          "--print-issued-lines=false",
          "--print-linter-name=false",
          "--path-prefix",
          function()
            return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
          end,
        },
        ignore_exitcode = true,
        parser = function(output)
          local results = {}
          local ok, decoded = pcall(vim.json.decode, output)
          if not ok then
            return results
          end

          if decoded.Issues then
            for _, issue in ipairs(decoded.Issues) do
              table.insert(results, {
                lnum = issue.Pos.Line - 1,
                col = issue.Pos.Column - 1,
                message = issue.Text,
                severity = vim.diagnostic.severity.WARN,
                source = "golangci-lint",
                code = issue.FromLinter,
              })
            end
          end
          return results
        end,
      }

      lint.linters_by_ft = {
        javascript = { "eslint" },
        typescript = { "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },
        svelte = { "eslint" },
        python = { "mypy", "flake8" },
        go = { "golangci_lint" },
        markdown = { "markdownlint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  }

  use {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          svelte = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
          lua = { "stylua" },
          python = { "black", "isort" },
          go = { "gofumpt", "goimports" },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 5000,
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>f", function()
        vim.lsp.buf.format()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 5000,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  }

  -- use { unpack(require 'plugins.plantuml') }

  --
  -- use {
  --   'filipdutescu/renamer.nvim',
  --   branch = 'master',
  --   requires = { {'nvim-lua/plenary.nvim'} }
  -- }
  --

  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require 'plugins.luasnip'
    end,
  }

  -- use {
  --   'rcarriga/nvim-dap-ui',
  --   requires = {'mfussenegger/nvim-dap'},
  --   config = function()
  --     require 'dap'
  --   end,
  -- }

  -- AI

  -- use 'stevearc/dressing.nvim'
  -- use 'nvim-lua/plenary.nvim'
  -- use 'MunifTanjim/nui.nvim'
  -- use 'MeanderingProgrammer/render-markdown.nvim'
  --
  -- use 'hrsh7th/nvim-cmp'
  -- use 'nvim-tree/nvim-web-devicons'
  -- use 'HakonHarnes/img-clip.nvim'
  -- use 'zbirenbaum/copilot.lua'
  --
  -- use {
  --   'yetone/avante.nvim',
  --   branch = 'main',
  --   run = 'make',
  --   config = function()
  --     require('avante').setup({
  --       provider = 'openai',
  --       auto_suggestions_provider = "openai",
  --       openai = {
  --         endpoint = "https://api.openai.com/v1",
  --         model = "gpt-4o-mini",
  --         timeout = 30000,               -- Timeout in milliseconds, increase this for reasoning models
  --         temperature = 0,
  --         max_completion_tokens = 16384, -- Increase this to include reasoning tokens (for reasoning models)
  --         reasoning_effort = "medium",   -- low|medium|high, only used for reasoning models
  --       },
  --     })
  --   end
  -- }

  -- -- Go development
  -- use {
  --   'fatih/vim-go',
  --   run = ':GoUpdateBinaries',
  --   ft = 'go',
  --   config = function()
  --     -- Disable vim-go LSP features since we're using gopls through nvim-lspconfig
  --     vim.g.go_def_mapping_enabled = 0
  --     vim.g.go_doc_keywordprg_enabled = 0
  --     vim.g.go_code_completion_enabled = 0
  --     vim.g.go_gopls_enabled = 0
  --
  --     -- Enable useful vim-go features
  --     vim.g.go_fmt_autosave = 0  -- We handle formatting through conform.nvim
  --     vim.g.go_imports_autosave = 0  -- We handle imports through conform.nvim
  --     vim.g.go_highlight_types = 1
  --     vim.g.go_highlight_fields = 1
  --     vim.g.go_highlight_functions = 1
  --     vim.g.go_highlight_function_calls = 1
  --     vim.g.go_highlight_operators = 1
  --     vim.g.go_highlight_extra_types = 1
  --     vim.g.go_highlight_build_constraints = 1
  --     vim.g.go_highlight_generate_tags = 1
  --
  --     -- Test settings
  --     vim.g.go_test_show_name = 1
  --     vim.g.go_test_timeout = '10s'
  --
  --     -- Template settings
  --     vim.g.go_template_autocreate = 1
  --   end
  -- }

  use {
    "Exafunction/windsurf.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
      })
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)
