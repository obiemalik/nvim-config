<h3 align="center">
Neovim Configuration with Lua
</h3>

## Table of Contents

- [Plugins](#plugins)
- [Directory Tree](#directory-tree)
- [Files and Settings](#files-and-settings)
- [Installation](#installation)
- [LSP Configuration](#lsp-configuration)
- [Appearance](#appearance)
- [Keymaps](#keymaps)
- [Configuration Check](#configuration-check)
- [Screenshots](#screenshots)

## Files and Settings

`/nvim`

- [init.lua](nvim/init.lua): Main configuration file that call `lua` modules
- [lua](nvim/lua): Folder of `lua` modules, here reside all the Lua modules that needed. These modules are called from `init.lua` file (see below).
  See: https://github.com/nanotee/nvim-lua-guide#where-to-put-lua-files

`/nvim/lua`

- [packer_init.lua](nvim/lua/packer_init.lua): Load plugins

`/nvim/lua/core`

- [autocmds.lua](nvim/lua/core/autocmds.lua): Define autocommands with Lua APIs
- [colors.lua](nvim/lua/core/colors.lua): Define Neovim and plugins color scheme
- [keymaps.lua](nvim/lua/core/keymaps.lua): Keymaps configuration file, vim/neovim and plugins keymaps
- [options.lua](nvim/lua/core/options.lua): General Neovim settings
- [statusline.lua](nvim/lua/core/statusline.lua): Statusline configuration file

`/nvim/lua/plugins`

- [packer.lua](nvim/lua/plugins/packer.lua): Plugin manager settings
- [alpha-nvim.lua](nvim/lua/plugins/alpha-nvim.lua): Dashboard
- [indent-blankline.lua](nvim/lua/plugins/indent-blankline.lua): Indent line
- [nvim-cmp.lua](nvim/lua/plugins/nvim-cmp.lua): Autocompletion settings
- [nvim-lspconfig.lua](nvim/lua/plugins/nvim-lspconfig.lua): LSP configuration (language servers, keybinding)
- [nvim-tree.lua](nvim/lua/plugins/nvim-tree.lua): File manager settings
- [nvim-treesitter](nvim/lua/plugins/nvim-treesitter): Treesitter interface configuration

## Installation

1. Install [Neovim v0.8.x](https://github.com/neovim/neovim/releases/latest).
2. Install [Nerd Fonts](https://www.nerdfonts.com/font-downloads), (for the font of the screenshots install [Cozette Font](https://github.com/slavfox/Cozette)).
3. Install [npm](https://github.com/npm/cli) for download packages of LSP language servers, see: [LSP Configuration](#lsp-configuration).
4. Make a backup of your current `nvim` folder if necessary:

```term
mv ~/.config/nvim ~/.config/nvim.backup
```

5. Download `nvim-config` with `git` and copy the `nvim` folder in the `${HOME}/.config` directory:

```term
git clone https://github.com/obiemalik/nvim-config.git
cd nvim-config/
cp -Rv nvim ~/.config/
```

6. Install [packer.nvim](https://github.com/wbthomason/packer.nvim) for install and manage the plugins:

```term
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

7. Run Neovim with `PackerSync` command:

```term
nvim +PackerSync
```

## LSP Configuration

1. Language servers are configured in `nvim/lua/lsp/` and are installed using via `nvim/lua/packer_init.lua:235`. You will have to determine which of these are required and install them with with `npm`

```term
sudo npm install -g {language_server}
```

2. Install additional packages for plugins support:

**C, C++:**

- [clang](https://clangd.llvm.org/installation.html) for use LSP with [clangd](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#clangd).
- [ctags](https://github.com/universal-ctags/ctags) to view tags with [Tagbar](https://github.com/preservim/tagbar).

**Python:**

- [pynvim](https://github.com/neovim/pynvim)

### Languages Currently Supported

Open a source file of one of the supported languages with Neovim, and run command [:LspInfo](https://github.com/neovim/nvim-lspconfig#built-in-commands) for testing the LSP support.

Lua - [builtin](https://neovim.io/doc/user/lua.html)
<<<<<<< Updated upstream
Bash - [bashls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#bashls)
Python - [pyright](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#pyright)
C, C++ - [clangd](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#clangd)
HTML, CSS, JSON - [vscode-html](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#html)
JavaScript, TypeScript - [ts_ls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ts_ls)
=======
Bash - [bashls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls)
Python - [pyright](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright)
C, C++ - [clangd](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd)
HTML, CSS, JSON - [vscode-html](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html)
>>>>>>> Stashed changes

See: [nvim-lspconfig #doc/configs.md](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md)

## Appearance

### Available Colorschemes

- [Catpuccin]
- [PaperColor]
- [OneDark](https://github.com/navarasu/onedark.nvim)
- [Neovim Monokai](https://github.com/tanvirtin/monokai.nvim)
- [Rose Pine](https://github.com/rose-pine/neovim)

**Fonts:** [Cozette](https://github.com/slavfox/Cozette)
**Icons:** [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)

- Neovim UI - [nvim/lua/core/colors.lua](nvim/lua/core/colors.lua):
  Set path to the correct color scheme:

```lua
return require('core/colorschemes/catppuccin');
```

- Statusline - [nvim/lua/plugins/feline.lua](nvim/lua/core/statusline.lua):
  The color scheme is picked up from [nvim/lua/core/colors.lua](nvim/lua/core/colors.lua)

## Keymaps

These are the default keymaps, in the following shortcuts, the `<leader>` key is set up to `,` (comma) character, see: [keymaps.lua](nvim/lua/core/keymaps.lua).

| Shortcut             | Mode          | Description                                    |
| -------------------- | ------------- | ---------------------------------------------- |
| `kk`                 | Insert        | Esc with `kk`                                  |
| `<leader>c`          | Normal        | Clear search highlights                        |
| `<F2>`               | Normal        | Toggle Paste mode                              |
| `<leader>tk/th`      | Normal        | Change split orientation (vertical/horizontal) |
| `<Ctrl> + {h,j,k,l}` | Normal        | Move around splits windows                     |
| `<leader>r`          | Normal        | Reload configuration file                      |
| `<leader>s`          | Normal/Insert | Save file                                      |
| `<leader>q`          | Normal        | Save (close all windows) and exit from Neovim  |
| `<Ctrl> + t`         | Normal        | Open terminal (`:Term`)                        |
| `<Esc>`              | Terminal      | Exit terminal                                  |
| `<Ctrl> + n`         | Normal        | Open NvimTree                                  |
| `<leader>z`          | Normal        | Open Tagbar                                    |

## Configuration check

- Open nvim and run command `checkhealth`, you should not see any error in the output (except for the one related to the Python 2 interpreter if don't have it):

```vim
:checkhealth
```

- You can also use the `startuptime` option to read the nvim startup logs:

```term
nvim --startuptime > /tmp/nvim-start.log
nvim /tmp/nvim-start.log
```

See: `:help startuptime`

## Guides and resources

- https://neovim.io/doc/user/lua.html
- https://github.com/nanotee/nvim-lua-guide
- https://dev.to/vonheikemen/everything-you-need-to-know-to-configure-neovim-using-lua-3h58
- https://www.old.reddit.com/r/neovim/

## Lua resources

- Lua in Y minutes - https://learnxinyminutes.com/docs/lua/
- Lua Quick Guide - https://github.com/medwatt/Notes/blob/main/Lua/Lua_Quick_Guide.ipynb
- Lua 5.4 Reference Manual - https://www.lua.org/manual/5.4/
