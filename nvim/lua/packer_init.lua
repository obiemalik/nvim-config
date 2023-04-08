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
  packer_bootstrap = fn.system({
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

-- Install plugins
return packer.startup(function(use)
  use { 'wbthomason/packer.nvim' }

  -- UI --
  use { 'kyazdani42/nvim-tree.lua' } -- File explorer
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  }
  use { -- Telescope (Fuzzy File Search)
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    requires = {
      { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
  }

  use { 'windwp/nvim-spectre' } -- Search/Replace Panel
  use { 'kyazdani42/nvim-web-devicons' } -- Icons
  use { 'preservim/tagbar' } -- Tag viewer
  use { -- Bufferline
    'akinsho/bufferline.nvim',
    tag = "v2.*",
  }
  use { 'feline-nvim/feline.nvim' } -- Statusline
  use { 'goolord/alpha-nvim' } -- Dashboard (start screen)
  use { 'folke/zen-mode.nvim' } -- Zen Mode

  -- Color schemes --

  use { 'NLKNguyen/papercolor-theme' }
  use { 'navarasu/onedark.nvim' }
  use { 'tanvirtin/monokai.nvim' }
  use { "catppuccin/nvim", as = "catppuccin" }
  use {
    'rose-pine/neovim',
    as = 'rose-pine',
  }

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

  -- EDITOR --

  use { 'airblade/vim-rooter' } -- Root Workspace to Project
  use { -- GIT Labels
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

  use { 'JoosepAlviste/nvim-ts-context-commentstring' } -- TSX Comments
  use { -- Peek Goto Line
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup()
    end,
  }
  -- use { -- Highlight TODO/FIXME/...
  --   'folke/todo-comments.nvim',
  --   requires = 'nvim-lua/plenary.nvim',
  --   config = function()
  --     require('todo-comments').setup()
  --   end,
  -- }
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
      require('plugins/treesitter')
    end,
    requires = {
      'windwp/nvim-ts-autotag', -- Automatically end & rename tags
      -- Dynamically set commentstring based on cursor location in file
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/playground',
    },
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
      require 'lsp'
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
      }, {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
          require 'lsp.null_ls'
        end,
      },
      'jose-elias-alvarez/typescript.nvim',
      'folke/lua-dev.nvim',
    },
  }

  use { 'MunifTanjim/prettier.nvim', config = function() require 'plugins.prettier' end }

  -- use { 'mhartington/formatter.nvim' }
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
