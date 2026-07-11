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
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    vim.o.runtimepath = vim.fn.stdpath("data")
        .. "/site/pack/*/start/*,"
        .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost packer_init.lua source <afile> | PackerSync
augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

packer.init({
    git = {
        clone_timeout = 120,
    },
    max_jobs = 10,
})

-- Install plugins
return packer.startup(function(use)
    use({ "wbthomason/packer.nvim" })

    -- UI --
    use({
        "kyazdani42/nvim-tree.lua", -- File explorer
        config = function()
            require("plugins/nvim-tree")
        end,
    })
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
    })
    use({ "nvim-lua/plenary.nvim" })
    use({ -- Telescope (Fuzzy File Search)
        "nvim-telescope/telescope.nvim",
        tag = "v0.2.2",
        requires = {
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim" },
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
    })

    use({ -- Search/Replace Panel
        "MagicDuck/grug-far.nvim",
        config = function()
            require("plugins.grug-far")
        end,
    })
    use({ "preservim/tagbar" }) -- Tag viewer
    use({ -- Bufferline
        "akinsho/bufferline.nvim",
        tag = "*",
        requires = "nvim-tree/nvim-web-devicons",
    })
    use({ "feline-nvim/feline.nvim" }) -- Statusline
    use({ -- Lua type support for the Neovim API and installed plugins
        "folke/lazydev.nvim",
        ft = "lua",
        config = function()
            require("plugins.lazydev")
        end,
    })
    use({ "goolord/alpha-nvim" }) -- Dashboard (start screen)
    use({ "folke/zen-mode.nvim" }) -- Zen Mode
    use({ -- Fuzzy Search
        "folke/flash.nvim",
        config = function()
            require("plugins/flash")
        end,
    })

    -- Color schemes --

    use({ "NLKNguyen/papercolor-theme" })
    use({ "navarasu/onedark.nvim" })
    use({ "tanvirtin/monokai.nvim" })
    use({ "catppuccin/nvim", as = "catppuccin" })
    use({ "miikanissi/modus-themes.nvim" })
    use({ "bluz71/vim-moonfly-colors", as = "moonfly" })
    use({ "nyoom-engineering/oxocarbon.nvim" })

    use({ -- Keybinding Popup
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup()
        end,
    })

    -- GIT --

    use({ -- Git Diffview
        "sindrets/diffview.nvim",
        requires = "nvim-lua/plenary.nvim",
    })
    use({ -- Git Conflict
        "akinsho/git-conflict.nvim",
        config = function()
            require("git-conflict").setup()
        end,
    })
    use({
        "tveskag/nvim-blame-line",
    })

    -- EDITOR --

    use({ "airblade/vim-rooter" }) -- Root Workspace to Project
    use({ -- GIT Labels
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("gitsigns").setup()
        end,
    })
    use({ -- Comments
        "numToStr/Comment.nvim",
        requires = "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
            require("Comment").setup({
                pre_hook = require(
                    "ts_context_commentstring.integrations.comment_nvim"
                ).create_pre_hook(),
            })
        end,
    })

    use({ -- Peek Goto Line
        "nacro90/numb.nvim",
        config = function()
            require("numb").setup()
        end,
    })

    use({ -- Highlight TODO/FIXME/...
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup()
        end,
    })
    use({ -- NPM Package Info
        "vuki656/package-info.nvim",
        requires = "MunifTanjim/nui.nvim",
        config = function()
            require("package-info").setup()
        end,
    })

    use({ -- Markdown Preview
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
            vim.g.mkdp_auto_close = 0
            vim.g.mkdp_markdown_css = "./custom/markdown-override.css"
        end,
        ft = { "markdown" },
    })

    use({ -- Surround Code Blocks
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end,
    })
    use({ -- Autopair
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                enabled = false,
            })
        end,
    })
    use({ -- Render HEX Colors
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    })
    use({ "lukas-reineke/indent-blankline.nvim" }) -- Show Indent Markers

    -- Treesitter (Code Highlighting)
    use({
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        run = ":TSUpdate",
        config = function()
            require("plugins.nvim-treesitter")
        end,
        requires = {
            {
                "windwp/nvim-ts-autotag", -- Automatically end & rename tags
                config = function()
                    require("nvim-ts-autotag").setup()
                end,
            },
        },
    })

    -- Dynamically set commentstring based on cursor location in file
    use({
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
            vim.g.skip_ts_context_commentstring_module = true
            require("ts_context_commentstring").setup({ enable_autocmd = false })
        end,
    })

    use({
        "m-demare/hlargs.nvim",
        config = function()
            require("hlargs").setup()
        end,
    })

    use({
        "ThePrimeagen/refactoring.nvim", -- Refactor
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
            { "lewis6991/async.nvim" },
        },
    })

    use({ -- Test runner
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/nvim-nio",
            "nvim-neotest/neotest-python",
        },
        config = function()
            require("plugins.neotest")
        end,
    })

    use({ "gbprod/stay-in-place.nvim" }) -- Fix Indent Cursor Position
    use({ "AndrewRadev/splitjoin.vim" }) -- Spread code-block

    use({
        "lewis6991/hover.nvim",
        config = function()
            require("plugins.hover")
        end,
    })

    -- LSP
    use({
        "neovim/nvim-lspconfig", -- Built-in LSP configurations
        config = function()
            require("lsp.mason")
            require("lsp")
            require("lsp.bash_ls")
            require("lsp.css_ls")
            require("lsp.docker_ls")
            require("lsp.graphql_ls")
            require("lsp.json_ls")
            require("lsp.php_ls")
            require("lsp.ts_ls")
            require("lsp.eslint_ls")
            require("lsp.yaml_ls")
            require("lsp.lua_ls")
            require("lsp.terraform_ls")
            require("lsp.haskell_ls")
            require("lsp.ltex_ls")
            require("lsp.prisma_ls")
            require("lsp.html_ls")
            require("lsp.svelte_ls")
            require("lsp.tailwind_ls")
            require("lsp.python_ls")
            require("lsp.rust_ls")
            require("lsp.go_ls")
        end,
        requires = {
            {
                "hrsh7th/nvim-cmp",
                requires = {
                    "hrsh7th/cmp-nvim-lsp",
                    "hrsh7th/cmp-buffer",
                    "hrsh7th/cmp-path",
                    "saadparwaiz1/cmp_luasnip",
                    "petertriho/cmp-git",
                },
                config = function()
                    require("plugins.nvim-cmp")
                end,
            },
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        run = ":MasonUpdate",
    })

    use({
        "MunifTanjim/prettier.nvim",
        config = function()
            require("plugins.prettier")
        end,
    })

    use({
        "mfussenegger/nvim-lint",
        config = function()
            require("plugins.nvim-lint")
        end,
    })

    use({
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.conform")
        end,
    })

    use({
        "L3MON4D3/LuaSnip",
        config = function()
            require("plugins.luasnip")
        end,
    })

    -- Go development
    use({
        "fatih/vim-go",
        run = ":GoUpdateBinaries",
        ft = "go",
        config = function()
            require("plugins.vim-go")
        end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    if packer_bootstrap then
        require("packer").sync()
    end
end)
