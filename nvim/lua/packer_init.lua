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

  use { 'nvim-pack/nvim-spectre' }       -- Search/Replace Panel
  use { 'kyazdani42/nvim-web-devicons' } -- Icons
  use { 'preservim/tagbar' }             -- Tag viewer
  use {                                  -- Bufferline
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
  use {
    'rose-pine/neovim',
    as = 'rose-pine',
  }
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

  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
  }

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
      require 'lsp.tsserver_ls'
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
      'jose-elias-alvarez/typescript.nvim',
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

      lint.linters_by_ft = {
        javascript = { "eslint" },
        typescript = { "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },
        svelte = { "eslint" },
        python = { "mypy", "flake8" },
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

      local prettier_eslint_fn = function()
        vim.cmd('EslintFixAll')
        return { "prettier" }
      end

      conform.setup({
        formatters_by_ft = {
          javascript = prettier_eslint_fn,
          typescript = prettier_eslint_fn,
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
          python = { "black", "isort" }
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 5000,
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>f", function()
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

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)
