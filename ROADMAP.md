# Roadmap

## Code Navigation & Motion

- [x] **Jump-to-anywhere motion** — flash.nvim, `lua/plugins/flash.lua`.

## Color Schemes & Theming

- [x] **Multiple colorscheme library** — papercolor, onedark, monokai, catppuccin, modus, moonfly, oxocarbon (`lua/core/themes/colorschemes/*.lua`).
- [x] **Color scheme picker UI** — `<leader>tc` (`:ColorSchemePicker`), `lua/core/themes/colors_picker.lua`.
- [x] **Auto light/dark colorscheme on startup** — `lua/core/themes/colors.lua` now reads the macOS system appearance (`defaults read -g AppleInterfaceStyle`) instead of Warp's own theme setting, so it tracks the OS toggle regardless of terminal. Default dark scheme switched to `catppuccin-mocha`.
- [x] **Inline HEX color highlighting** — nvim-colorizer.lua.
- [x] **Current-line highlight + block insert-mode cursor** — `opt.cursorline`, `opt.guicursor` (`lua/core/options.lua`); blink params dropped since the terminal (Warp) doesn't honor blink escape codes.

## Comments

- [x] **Toggle line/block comments** — Comment.nvim, treesitter-aware commentstring via nvim-ts-context-commentstring.
- [x] **Highlight TODO/FIXME/etc. annotations** — todo-comments.nvim.

## Completion & Snippets

- [x] **Autocompletion** (LSP, buffer, path, snippet, git sources) — nvim-cmp, `lua/plugins/nvim-cmp.lua`.
- [x] **Snippet expansion engine** — LuaSnip, `lua/plugins/luasnip.lua`.
- [x] **Custom language snippets** — go, javascript, lua, typescript, typescriptreact, vue (`lua/snippets/*.lua`).
- [x] **Neovim/plugin Lua API type info in completion** — lazydev.nvim (`lua/plugins/lazydev.lua`), lazy-loaded on `ft=lua`, replaces the never-configured `folke/lua-dev.nvim` dependency; wired as an nvim-cmp source (`group_index = 0`).

## Dashboard

- [x] **Start screen on launch** — alpha-nvim.

## File Explorer

- [x] **Toggleable file tree sidebar** — `<C-n>`, nvim-tree, `lua/plugins/nvim-tree.lua`.
- [x] **Auto-close/reopen file tree around diff view** — `DVO`/`DVC` commands close NvimTree before Diffview opens (in its own tab) and reopen it after, working around NvimTree's own tab-sync racing the close (`lua/core/commands.lua`).

## Formatting & Linting

- [x] **Format on save + manual format keymap** — `<leader>f`, conform.nvim, per-filetype formatters (prettierd/prettier, stylua, black/ruff, gofumpt/goimports, shfmt). Fixed two bugs blocking this: a `stylua.toml` typo (`indent_type = "Space"` instead of `"Spaces"`, plus width 2→4) that made stylua fail outright and silently leave buffers unformatted, and a conflicting `BufWritePre` autocmd in `lsp/init.lua` that ran each LSP server's own built-in formatter after conform's and clobbered its output for Lua/Go.
- [x] **Async linting on save/insert-leave + manual trigger** — `<leader>l`, nvim-lint, including a Mason-resolved `golangci-lint` integration.
- [x] **Per-filetype lint toggle** — `<leader>lt` / `:LintToggle [filetype]`, `lua/plugins/nvim-lint.lua`; disables linting and clears diagnostics for a filetype without touching the global config.
- [x] **Prettier integration** — prettier.nvim.

## Fuzzy Finding & Search

- [x] **Fuzzy file/buffer/help/oldfiles/quickfix finder** — `<leader>ff`/`fg`/`fb`/`fh`/`fs`/ `fo`/`fq`, Telescope.
- [x] **Git status/commits/branches pickers** — `<leader>fx`/`fc`/`fB`.
- [x] **Native fuzzy sorting + dropdown picker UI** — fzf-native and ui-select extensions.
- [x] **Project-wide search & replace panel** — `<leader>sp`/`sw`/`sv`/`sf`, grug-far.nvim (replaced nvim-spectre for a cleaner UI).
- [x] **Preview pane scrolling + focus** — `<C-f>`/`<C-u>` scroll the preview, `<C-p>` hops focus into the preview window and back without closing the picker (`noautocmd` workaround for telescope#2778), `lua/plugins/telescope.lua`. Buffer delete moved from `<C-d>` to `<C-x>` to make room.

## Git Integration

- [x] **Git change indicators in the gutter** — gitsigns.nvim.
- [x] **Merge conflict resolution keymaps** — `co`/`ct`/`cb`/`c0`, `]x`/`[x`, git-conflict.nvim.
- [x] **Side-by-side diff/history viewer** — `DVO`/`DVC`/`DVR`/`DVF`, diffview.nvim.
- [x] **Inline git blame toggle** — `<leader>bl`, nvim-blame-line.
- [x] **Auto-set cwd to project root** — vim-rooter.

## Go Development

- [x] **Go build/run/test/docs/tags tooling** — vim-go, lazy-loaded on `ft=go`, LSP features deferred to `gopls`/nvim-lspconfig, formatting deferred to conform.nvim.
- [x] **Go-specific editor behavior** — tabs/width, `<leader>g*` keymaps, abbreviations, `go.mod` tidy on save, build-tag detection (`lua/plugins/go.lua`).
- [x] **Fixed `gopls` never actually starting** — `lua/lsp/go_ls.lua` was configuring/enabling `dockerls` (copy-paste artifact) instead of `gopls`; Go projects were silently running without a language server.

## Hover & Documentation

- [x] **Hover documentation popup** — `K`/`gK`, hover.nvim.

## JavaScript/TypeScript Support

- [x] **Language server** (completions, inlay hints, diagnostics) — `tsc_native` (TypeScript 7 native compiler, `tsc --lsp --stdio`), covers `.js`/`.jsx`/`.ts`/`.tsx`, `lua/lsp/typescript.lua`. Replaces `ts_ls`/typescript-language-server (`lua/lsp/ts_ls.lua`, removed), which broke once Mason started resolving `typescript@7` — no more `tsserver.js` to back it.
- [x] **Linting** — ESLint via both the `eslint` LSP (code actions, flat-config aware, `lua/lsp/eslint_ls.lua`) and nvim-lint's `eslint` linter on save.
- [x] **Formatting** — prettierd/prettier via conform.nvim for js/ts/jsx/tsx (ESLint formatting explicitly disabled in favor of Prettier).
- [x] **JSX/TSX tag auto-close/rename** — nvim-ts-autotag.
- [x] **Snippets** — `lua/snippets/{javascript,typescript,typescriptreact}.lua`.
- [ ] **oxlint as the default linter** — `oxlint` (Rust-based, much faster) becomes the default for js/ts/jsx/tsx; only fall back to ESLint when the project has its own ESLint config present (`.eslintrc*`/`eslint.config.*`). Needs root-pattern detection in `lua/lsp/eslint_ls.lua`/`lua/plugins/nvim-lint.lua` to pick the linter per project.
- [ ] **oxfmt as the default formatter** — same precedence once `oxfmt` ships (part of the Oxc toolchain, not yet released as of writing): default to `oxfmt` in conform.nvim, fall back to Prettier only when the project has its own Prettier config present (`.prettierrc*`/`prettier.config.*`).

## Keybinding Help

- [x] **Keymap discovery popup** — which-key.nvim.

## Language Server Protocol (LSP)

- [x] **LSP/tool install management** — Mason, mason-lspconfig, mason-tool-installer.
- [x] **Language server coverage** — bash, css, docker, graphql, json, php, tsc_native, eslint, yaml, lua, terraform, haskell, ltex, prisma, html, svelte, tailwind, python, rust, go (`lua/lsp/*_ls.lua`).
- [x] **Shared LSP keymaps** (go-to-definition, hover, code actions, rename, diagnostics nav) — `lua/lsp/init.lua`. Fixed a bug where these (including `rn` rename) only ever applied to `pyright`, since `M.on_attach` was called manually from just `python_ls.lua`; now wired via a global `LspAttach` autocmd so every server gets them.
- [x] **Per-machine language toolchain gating** — `lua/config/langs.lua` reads a gitignored `lua/langs.lua` (copied from `lua/langs.example.lua`) or auto-detects via `PATH`; Mason installs, LSP servers (`lua/lsp/go_ls.lua`, `python_ls.lua`, `typescript.lua`), conform formatters, and nvim-lint linters all skip a toolchain when its flag is off.

## Markdown

- [x] **Live markdown preview in browser** — markdown-preview.nvim, lazy-loaded on `ft=markdown`.
- [x] **Soft-wrap markdown buffers** — `lua/core/autocmds.lua`, switched from `nowrap` to `wrap linebreak` so prose wraps at word boundaries instead of running off-screen.

## Monorepo Support

- [x] **Workspace root detection** — nearest `.git`.
- [x] **Project (sub-package) root detection** — nearest `package.json`/`go.mod`/ `Cargo.toml`/`composer.json`/`pyproject.toml`/`Makefile`, falling back to `.git`.
- [x] **Scoped fuzzy find/grep/search** — `<leader>ff`/`fg`/`fs` resolve against the active root instead of a fixed cwd.
- [x] **Search scope toggle** — `<leader>tw` switches between workspace and project scope, with a notification showing the active scope and resolved path.
- [x] **Persistent scope indicator** — `WKS`/`PRJ` badge (skyblue/orange) in the statusline next to the mode indicator, `lua/core/statusline.lua`, updates live via `redrawstatus` on toggle.
- [ ] **LSP roots follow the same scope** — `tsserver`/`gopls`/`eslint`/etc. in `lua/lsp/*.lua` pick their own root heuristics today, independent of the Telescope scope. Wrong root causes bad `node_modules` resolution, cross-package false-positive diagnostics, slower indexing. Likely the highest-value item here.
- [ ] **Smarter workspace-root detection** — "workspace root" is currently just the nearest `.git`, which breaks for real monorepo tooling (pnpm/yarn workspaces, Nx, Turborepo, Lerna, Rush) where the meaningful root is `pnpm-workspace.yaml`/`nx.json`/`turbo.json`/ etc., and for polyrepo setups with no shared `.git`.
- [ ] **Detect whether the workspace actually has sub-projects** — `Workspace.has_subprojects()`: check for a known monorepo manifest at the root first (`pnpm-workspace.yaml`/`lerna.json`/`nx.json`/`turbo.json`/`rush.json`/`go.work`/`Cargo.toml` with `[workspace]`), falling back to a bounded downward `vim.fs.find(markers, { path = workspace_root, upward = false, limit = 2 })` scan for a second marker below the root. Lets the UI (e.g. the `WKS`/`PRJ` badge) stay quiet/disabled in plain single-package repos instead of always offering a toggle that does nothing useful. Manifest detection doubles as the source of truth for the jump-to-sub-package picker below.
- [ ] **Reconcile with auto-cwd-on-open behavior** — `vim-rooter` already changes `cwd` on its own heuristics; confirm it isn't fighting the Telescope scope logic, which tracks root separately rather than mutating global `cwd`.
- [ ] **Jump-to-sub-package picker** — a picker listing all sub-packages (globbing for workspace markers) to jump/cd directly, instead of only toggling between two fixed scopes.
- [ ] **Scoped terminal/task runner** — `:terminal` or build/test commands cwd'd to the current sub-package instead of the workspace root.

## NPM Tooling

- [x] **Inline `package.json` dependency version info** — package-info.nvim.

## Refactoring

- [x] **Refactor menu/prompt** — `<leader>rr` (visual mode), refactoring.nvim.
- [x] **Symbol rename popup** — `rn`, LSP rename float, `lua/lsp/init.lua`.

## Statusline & Bufferline

- [x] **Custom statusline** — feline.nvim, `lua/core/statusline.lua`.
- [x] **Buffer tabs** — bufferline.nvim.

## Syntax & Structure

- [x] **Treesitter-based syntax highlighting/indent** — nvim-treesitter (main branch, rewritten API), `lua/plugins/nvim-treesitter.lua`.
- [x] **Auto-close/rename HTML/JSX tags** — nvim-ts-autotag.
- [x] **Highlight function arguments** — hlargs.nvim.
- [x] **Indent guides** — indent-blankline.nvim.

## Testing

- [x] **Test runner with summary panel** — `<leader>ts`, neotest, Python adapter installed.

## Text Editing Utilities

- [x] **Surround text objects** — nvim-surround.
- [x] **Fix cursor position on indent** — stay-in-place.nvim.
- [x] **Spread/join code blocks** — splitjoin.vim.
- [x] **Peek line on `:{number}` jump** — numb.nvim.
- [ ] **Auto-close brackets/quotes** — nvim-autopairs installed but `enabled = false`; decide whether to turn on or remove.

## Zen Mode

- [x] **Distraction-free writing/coding mode** — `<leader>z`, zen-mode.nvim.
- [ ] **Dim inactive code outside focus** — Twilight integration referenced previously but the `twilight.nvim` dependency isn't installed; not currently active.
