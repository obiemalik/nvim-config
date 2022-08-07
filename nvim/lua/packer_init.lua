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
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
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
  use { 'wbthomason/packer.nvim' }                                                             -- packer can manage itself

  -- UI --
  use { 'kyazdani42/nvim-tree.lua' }                                                           -- File explorer
  use { 'nvim-telescope/telescope-fzf-native.nvim',run='make' }
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0',                                        -- Telescope (Fuzzy File Search)
  requires = {
    { 'nvim-lua/popup.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim' }
  }
}

use { 'windwp/nvim-spectre' }                                                                  -- Search/Replace Panel
use { 'kyazdani42/nvim-web-devicons' }                                                         -- Icons
use { 'preservim/tagbar' }                                                                     -- Tag viewer
use { 'akinsho/bufferline.nvim', tag = "v2.*" }                                                -- Bufferline
use { 'feline-nvim/feline.nvim' }                                                              -- Statusline
use { 'goolord/alpha-nvim' }                                                                   -- Dashboard (start screen)

-- Color schemes
use { 'NLKNguyen/papercolor-theme' }
use { 'navarasu/onedark.nvim' }
use { 'tanvirtin/monokai.nvim' }
use { 'rose-pine/neovim', as = 'rose-pine' }
use { 'folke/which-key.nvim', config = function() require('which-key').setup() end }           -- Keybinding Popup

use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }                           -- Git Diffview
use { 'akinsho/git-conflict.nvim', config = function() require('git-conflict').setup() end }   -- Git Conflict

-- EDITOR --

use 'airblade/vim-rooter'                                                                      -- Root Workspace to Project
use { 'lewis6991/gitsigns.nvim',                                                               -- GIT Labels
requires = { 'nvim-lua/plenary.nvim' },
config = function() require('gitsigns').setup() end
  }
  use { 'numToStr/Comment.nvim',  config = function() require('Comment').setup() end }         -- Comments

  use 'JoosepAlviste/nvim-ts-context-commentstring'                                            -- TSX Comments
  use { 'nacro90/numb.nvim', config = function() require('numb').setup() end }                 -- Peek Goto Line
  use { 'folke/todo-comments.nvim',                                                            -- Highlight TODO/FIXME/...
  requires = 'nvim-lua/plenary.nvim',
  config = function() require('todo-comments').setup() end
}
use { 'vuki656/package-info.nvim',                                                             -- NPM Package Info
requires = 'MunifTanjim/nui.nvim',
config = function() require('package-info').setup() end
  }
  use { 'iamcco/markdown-preview.nvim',                                                        -- Markdown Preview
  run = 'cd app && npm install',
  setup = function() vim.g.mkdp_filetypes = { 'markdown' } end, ft = { 'markdown' }
}

use { 'kylechui/nvim-surround', config = function() require('nvim-surround').setup() end }     -- Surround Code Blocks
use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup() end }     -- Autopair
use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end }    -- Render HEX Colors
use { "lukas-reineke/indent-blankline.nvim" }                                                  -- Show Indent Markers

-- Treesitter (Code Highlighting)
use { 'nvim-treesitter/nvim-treesitter',
run = ':TSUpdate',
config = function() require('plugins/nvim-treesitter') end,
requires = {
  'windwp/nvim-ts-autotag', -- Automatically end & rename tags
  -- Dynamically set commentstring based on cursor location in file
  'JoosepAlviste/nvim-ts-context-commentstring',
  'nvim-treesitter/playground',
},
  }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', after = { 'nvim-treesitter' } }
  use { 'RRethy/nvim-treesitter-textsubjects', after = { 'nvim-treesitter' } }
  use { 'm-demare/hlargs.nvim', config = function() require('hlargs').setup() end }
	use { "ThePrimeagen/refactoring.nvim",
    requires = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-treesitter/nvim-treesitter"}
    },
		config = function() require('refactoring').setup({}) end
	}



  use { 'gbprod/stay-in-place.nvim' }                                                          -- Fix Indent Cursor Position
  use { 'AndrewRadev/splitjoin.vim' }                                                          -- Spread code-block

  use {'lewis6991/hover.nvim', config = function()
    require('hover').setup{
      init = function()
        -- Require providers
        require('hover.providers.lsp')
        -- require('hover.providers.gh')
        -- require('hover.providers.man')
        -- require('hover.providers.dictionary')
      end,
      preview_opts = {
        border = nil
      },
      title = true
    }

    -- Setup keymaps
    vim.keymap.set('n',  'K', require('hover').hover       , { desc='hover.nvim' })
    vim.keymap.set('n', 'gK', require('hover').hover_select, { desc='hover.nvim (select)' })
  end}

  -- LSP

  use {
    'neovim/nvim-lspconfig',                                                                   -- Built-in LSP configurations
    config = function()
      require 'j.plugins.lsp'
      require 'j.plugins.lsp.css_ls'
      require 'j.plugins.lsp.docker_ls'
      require 'j.plugins.lsp.graphql_ls'
      require 'j.plugins.lsp.json_ls'
      require 'j.plugins.lsp.php_ls'
      require 'j.plugins.lsp.tsserver_ls'
      require 'j.plugins.lsp.vue_ls'
      require 'j.plugins.lsp.volar_ls'
      require 'j.plugins.lsp.yaml_ls'
      require 'j.plugins.lsp.lua_ls'
      require 'j.plugins.lsp.terraform_ls'
      require 'j.plugins.lsp.haskell_ls'
      require 'j.plugins.lsp.eslint_ls'
      require 'j.plugins.lsp.ltex_ls'
      require 'j.plugins.lsp.prisma_ls'
      require 'j.plugins.lsp.html_ls'
      require 'j.plugins.lsp.svelte_ls'
      require 'j.plugins.lsp.tailwind_ls'
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
          require 'j.plugins.cmp'
        end,
      },
      {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
          require 'j.plugins.lsp.null_ls'
        end,
      },
      'jose-elias-alvarez/typescript.nvim',
      'folke/lua-dev.nvim',
    },
  }

  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require 'j.plugins.luasnip'
    end,
  }

  use {
    'rcarriga/nvim-dap-ui',
    requires = { 'mfussenegger/nvim-dap' },
    config = function()
      require 'j.plugins.dap'
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)
