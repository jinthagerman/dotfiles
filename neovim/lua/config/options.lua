-- YADR-inspired options
-- These extend/override the LazyVim starter options

local opt = vim.opt

-- YADR-style preferences
opt.wrap = false -- Don't wrap lines by default
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers

-- Search settings
opt.ignorecase = true -- Ignore case in search
opt.smartcase = true -- Override ignorecase if search contains capitals
opt.hlsearch = true -- Highlight search results

-- Indentation (adjust based on your preferences)
opt.tabstop = 2 -- Number of spaces tabs count for
opt.shiftwidth = 2 -- Size of an indent
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Insert indents automatically

-- Visual settings
opt.cursorline = true -- Highlight current line
opt.scrolloff = 8 -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor

-- File handling
opt.backup = false -- Don't create backup files
opt.writebackup = false -- Don't create backup before overwriting
opt.swapfile = false -- Don't create swap files
opt.undofile = true -- Enable persistent undo

-- TODO: Add more YADR-specific options as needed
-- Examples to consider:
-- opt.colorcolumn = "80" -- Show column at 80 characters
-- opt.list = true -- Show invisible characters
-- opt.listchars = { tab = "▸ ", trail = "·", nbsp = "␣" }
