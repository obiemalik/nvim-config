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
- [claude-code.lua](nvim/lua/plugins/claude-code.lua): Claude Code integration ([claudecode.nvim](https://github.com/coder/claudecode.nvim)) keymaps

## Installation

1. Install [Neovim v0.8.x](https://github.com/neovim/neovim/releases/latest).
2. Install [Nerd Fonts](https://www.nerdfonts.com/font-downloads), (for the font of the screenshots install [Cozette Font](https://github.com/slavfox/Cozette)).
3. Install [npm](https://github.com/npm/cli) for download packages of LSP language servers, see: [LSP Configuration](#lsp-configuration).
3.5. Run [install-dependencies.sh](install-dependencies.sh) to install core tools (ripgrep, fd, fzf, stylua, shfmt, tree-sitter-cli). It only installs editor tooling, not language runtimes — it checks whether `go`/`python3`/`node` are on `PATH` and reports which are missing, since those gate what Mason/LSP/format/lint config gets enabled (see `langs.lua` below).
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

Go/Python/JavaScript/TypeScript toolchain installation (Mason tools, LSP servers, formatters, linters) is gated per-machine by `nvim/lua/langs.lua` — copy it from [langs.example.lua](nvim/lua/langs.example.lua) and set which toolchains this machine has. If absent, each language auto-detects by checking whether its executable (`go`, `python3`, `node`) is on `PATH`.

2. Install additional packages for plugins support:

**C, C++:**

- [clang](https://clangd.llvm.org/installation.html) for use LSP with [clangd](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#clangd).
- [ctags](https://github.com/universal-ctags/ctags) to view tags with [Tagbar](https://github.com/preservim/tagbar).

**Python:**

- [pynvim](https://github.com/neovim/pynvim)

### Languages Currently Supported

Open a source file of one of the supported languages with Neovim, and run command [:LspInfo](https://github.com/neovim/nvim-lspconfig#built-in-commands) for testing the LSP support.

Lua - [builtin](https://neovim.io/doc/user/lua.html)
Bash - [bashls](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#bashls)
Python - [pyright](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#pyright)
C, C++ - [clangd](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#clangd)
HTML, CSS, JSON - [vscode-html](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#html)
JavaScript, TypeScript - `tsc_native` (TypeScript 7 native compiler, `nvim/lua/lsp/typescript.lua`)

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

- On macOS, startup auto-picks light/dark based on the system appearance (`defaults read -g AppleInterfaceStyle`) — `catppuccin-mocha` for dark, `papercolor` for light — see [nvim/lua/core/themes/colors.lua](nvim/lua/core/themes/colors.lua).

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
| `<leader>lt`         | Normal        | Toggle linting for current filetype (`:LintToggle`) |
| `<leader>ac`         | Normal        | Toggle the pinned Claude Code split (session persists in background when hidden) |
| `<leader>af`         | Normal        | Focus the pinned Claude Code split, opening it if not already open |
| `<leader>as`         | Visual        | Send selection to Claude Code (`:ClaudeCodeSend`) |
| `<leader>aa`         | Normal        | Accept Claude Code diff (`:ClaudeCodeDiffAccept`) |
| `<leader>ad`         | Normal        | Deny Claude Code diff (`:ClaudeCodeDiffDeny`)  |

Opening a diff auto-zooms the tab and sizes the three panes (terminal / original / proposed) 20/40/40.

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
