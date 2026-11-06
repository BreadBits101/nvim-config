# Neovim IDE guide

This guide describes the configuration in this folder. `<leader>` is **Space**;
`<localleader>` is **backslash**. Open Neovim from a project directory so file
search, language servers, and terminal commands use the right working directory.
Check it with `:pwd` and change it with `:cd path/to/project`.

## Plugins and what they provide

| Plugin | Purpose |
| --- | --- |
| `lazy.nvim` | Installs and updates plugins. Use `:Lazy` for its interface and `:Lazy update` to update. |
| `nvim-lspconfig` | Supplies language-server definitions. This configuration enables the servers listed below. |
| `blink.cmp` | Completion from LSP, paths, snippets, and buffer text. |
| `fzf-lua` | File, text, buffer, help, and symbol search. It loads when you use one of its mappings. The external `fzf` executable must be on `PATH`; project text search also needs `rg`. |
| `nvim-tree.lua` | File explorer in a left sidebar. Use `<leader>ft` to toggle it or `<leader>fT` to reveal the current file. |
| `nvim-web-devicons` | File icons in search results; a Nerd Font is useful for displaying them. |
| `vimtex` | LaTeX editing, compilation, errors, and PDF navigation. Loads for `.tex`, `.bib`, and plain TeX files. |
| `gruvbox.nvim` | Color scheme. |

Plugins do not install language servers, compilers, or formatters. Those tools
must be installed on each machine and available on `PATH`.

## Finding your way around

| Keys / command | Action |
| --- | --- |
| `<leader>ff` | Find files. |
| `<leader>ft` | Toggle the file tree on the left (`:NvimTreeToggle`). |
| `<leader>fT` | Open the tree and reveal the current file (`:NvimTreeFindFile`). |
| `<leader>fg` | Search text in the project. |
| `<leader>fb` | Switch buffers. |
| `<leader>fr` | Open a recent file. |
| `<leader>fh` | Search Neovim help. |
| `<leader>fs` | Find symbols in the current document (requires LSP). |
| `<leader>fS` | Find workspace symbols (requires LSP). |
| `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` | Move between windows. |
| `:e path`, `:w`, `:q` | Open a file, save, quit. |
| `:split`, `:vsplit` | Open a horizontal or vertical split. |
| `:terminal` | Open a terminal in Neovim. Press `<Esc><Esc>` to leave terminal mode. |
| `"+y`, `"+p` | Copy to and paste from the operating-system clipboard. |

In the file tree, press `<Enter>` to open a file or expand a directory, `g?`
to see all tree keys, `a` to create a file or directory, `r` to rename, and
`d` to delete. Tree changes act on the selected filesystem item.

Search ignores case unless the query contains an uppercase letter. Press
`<Esc>` in normal mode to clear search highlighting. Visual-mode `<` and `>`
keep the selection after indenting; visual-mode `J` and `K` move selected lines.

## Coding with an attached language server

These mappings appear only after an LSP attaches to the buffer.

| Keys | Action |
| --- | --- |
| `gd`, `gD` | Go to definition or declaration. |
| `gr`, `gi`, `gy` | Find references, implementation, or type definition. |
| `K` | Show hover documentation. |
| `<C-k>` in insert mode | Show signature help. |
| `<leader>ca` | Code action (normal or visual mode). |
| `<leader>rn` | Rename symbol. |
| `<leader>cf` | Ask the LSP to format the buffer or selection. A formatter must be available through that server. |
| `<leader>wa`, `<leader>wr`, `<leader>wl` | Add, remove, or list LSP workspace folders. |

Diagnostics appear as virtual text, underlines, and signs. Use `[d` and `]d`
to jump between them, `<leader>e` for the diagnostic under the cursor, and
`<leader>q` to put diagnostics in the location list (`:lopen` opens it).
If an LSP feature is missing, check `:checkhealth vim.lsp` or inspect the
current buffer's clients with
`:lua print(vim.inspect(vim.lsp.get_clients({bufnr=0})))`.

### Completion keys (insert mode)

| Keys | Action |
| --- | --- |
| `<C-Space>` | Show completion and toggle its documentation. |
| `<C-n>`, `<C-p>` | Next or previous suggestion. |
| `<CR>` | Accept a suggestion. |
| `<C-e>` | Hide the menu. |
| `<Tab>`, `<S-Tab>` | Move forward or backward through snippet fields. |

## Language support and running code

| Files | Configured server / plugin | Build, run, and test examples from a project terminal |
| --- | --- | --- |
| C, C++ | `clangd` | Use your project's build system, such as `cmake -S . -B build-ninja -G Ninja`, then `cmake --build build-ninja` and `ctest --test-dir build-ninja`. `clangd` looks in `build-ninja` for compile commands. Configure CMake with `-DCMAKE_EXPORT_COMPILE_COMMANDS=ON` when needed. |
| Rust | `rust_analyzer` | `cargo build`, `cargo run`, `cargo test`, `cargo clippy`, `cargo fmt`. Install the Rust toolchain with `rustup`. |
| Python | `pyright` | `python script.py` and `python -m pytest` when your project uses pytest. The Jupyter workflow below uses a paired `.py` file. |
| JavaScript, TypeScript | `tsc` (TypeScript 7 native LSP), `eslint` | Use the scripts in your project's `package.json`, for example `npm run build` or `npm test`. The `tsc` LSP requires TypeScript 7 or newer on `PATH`. |
| HTML, CSS, JSON | `html`, `cssls`, `jsonls` | Editing, completion, and diagnostics. Build commands depend on the web project. |
| Java | `jdtls` when available | Use the project's Maven or Gradle wrapper, for example `./mvnw test` or `./gradlew test` on macOS; `mvnw.cmd test` or `gradlew.bat test` on Windows. |
| LaTeX, BibTeX | `vimtex` | Install a TeX distribution with `latexmk`; use the VimTeX commands below. |

Run the examples in a regular terminal or with `:terminal` inside Neovim.
This setup has no dedicated debugger or test-runner plugin.

### LaTeX with VimTeX

Open a `.tex` file, then use `\ll` to start continuous `latexmk` compilation,
`\lv` to view/forward-search in the PDF, `\le` for errors, and `\lk` to stop
compilation. The configured viewer is SumatraPDF on Windows when available on
`PATH`, or Skim on macOS when available.

### Jupyter notebooks

The documented notebook workflow uses Jupytext. Pair a notebook with a Python
percent-format file using `jupytext --set-formats ipynb,py:percent notebook.ipynb`,
edit the `.py` file in Neovim, then run `jupytext --sync notebook.py`. Use
JupyterLab to view rich output and plots. JupyterLab and Jupytext are external
tools, not Neovim plugins in this configuration.
