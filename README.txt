NEOVIM CONFIGURATION HANDOFF
=============================

Purpose
-------
This is a deliberately small, transparent Neovim setup for C, C++, Java,
Python, web development, and practical Jupyter-notebook editing. It is shared
between Windows and macOS through Git.

When helping with this folder, preserve one shared configuration. Do not split
it into Windows-only and macOS-only versions, and do not add machine-specific
user paths unless there is no practical alternative.


Current layout
--------------
init.lua                   Loads options, keymaps, and lazy.nvim.
lua/config/options.lua     Editor settings and leader keys.
lua/config/keymaps.lua     General and LSP-independent mappings.
lua/config/lazy.lua        Bootstraps lazy.nvim using vim.fn.stdpath("data").
lua/config/platform.lua    Central Windows/macOS/Linux detection helper.
lua/config/lsp.lua         LSP configuration and LSP keymaps.
lua/plugins/               Plugin specifications.
lazy-lock.json             Plugin version lockfile; keep it in Git.


Cross-platform requirements
---------------------------
* Use Neovim paths such as vim.fn.stdpath("config"), vim.fn.stdpath("data"),
  and vim.fn.stdpath("cache") rather than hard-coded OS paths.
* Resolve normal tools through PATH. For example, use cmd = { "clangd" }, not
  a path such as C:/Program Files/LLVM/bin/clangd.exe.
* Tools and language servers are installed independently on each device; Git
  synchronises only this configuration.
* Keep executable names consistent on PATH where possible: git, rg, fd, fzf,
  clang/clang++, clangd, cmake, ninja, java, Python, Node/npm, and relevant
  language servers/formatters.
* Windows config normally lives in %LOCALAPPDATA%\\nvim; macOS config normally
  lives in ~/.config/nvim.


Platform helper
---------------
lua/config/platform.lua exposes:

  platform.system
  platform.is_windows
  platform.is_mac
  platform.is_linux
  platform.executable("tool")

Use this helper for unavoidable OS-specific behavior.


JDTLS / Java
------------
JDTLS is the one intentional platform-specific LSP setup.

Default JDTLS locations:

  Windows: C:/Tools/jdtls       (uses config_win)
  macOS:   ~/tools/jdtls        (uses config_mac)

Set NVIM_JDTLS_HOME to override the default location on either system. JDTLS
is enabled only when all of these are present:

* Windows or macOS
* java is available through PATH
* the Eclipse launcher JAR exists
* the correct config_win or config_mac directory exists

If those conditions are not met, Java LSP is simply not enabled; the rest of
Neovim should keep working.


Plugins and mappings
--------------------
Core plugins:

* lazy.nvim       Plugin manager
* nvim-lspconfig  Language-server configuration
* blink.cmp       Completion
* fzf-lua         File/text/navigation search
* nvim-web-devicons
* gruvbox.nvim

fzf-lua is intentionally lazy-loaded. In :Lazy it appearing under "Not Loaded"
is normal, not an error. It loads when one of its mappings is used:

  <leader>ff  Find files
  <leader>fg  Search project text
  <leader>fb  Find buffers
  <leader>fh  Search help
  <leader>fr  Recent files
  <leader>fs  Document symbols
  <leader>fS  Workspace symbols

The leader key is Space.


Jupyter notebooks
-----------------
Prefer Jupytext as the low-maintenance cross-platform notebook workflow rather
than adding a complex in-editor notebook runtime.

Install JupyterLab and Jupytext separately in a project Python virtual
environment on each machine:

  python -m pip install jupyterlab jupytext

Pair an existing notebook with a Python percent-format file:

  jupytext --set-formats ipynb,py:percent notebook.ipynb

Edit the paired .py file in Neovim; it uses # %% cell markers. Sync with:

  jupytext --sync notebook.py

Open the .ipynb in JupyterLab for rich output, plots, and interactive tables.
Do not copy a macOS .venv to Windows (or the reverse); recreate it per project:

  python -m venv .venv

On Windows PowerShell, activate it with:

  .\.venv\Scripts\Activate.ps1

Then install project dependencies, ideally from requirements.txt:

  python -m pip install -r requirements.txt


Change policy
-------------
Before making changes, check this file and preserve the principles above.
Keep the plugin set small unless a requested capability has a clear benefit.
Commit configuration files and lazy-lock.json to Git; never commit local data,
cache directories, virtual environments, or machine-specific executable paths.
