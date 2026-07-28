-- Display
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.termguicolors = true

-- Editing
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Files and history
vim.opt.undofile = true
vim.opt.swapfile = true
vim.opt.backup = false
vim.opt.writebackup = false

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Responsiveness
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400

-- Keep the operating-system clipboard explicit at first.
-- Use "+y and "+p when you deliberately want the Windows clipboard.
-- Later, uncomment the following line if desired:
-- vim.opt.clipboard = "unnamedplus"

-- Leader must be defined before plugin mappings.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
