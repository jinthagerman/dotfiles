-- YADR-inspired keymaps
-- These extend/override the LazyVim starter keymaps

local map = vim.keymap.set

-- YADR-style buffer navigation
map("n", ",z", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", ",x", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- File navigation (replaces CtrlP shortcuts)
map("n", ",t", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", ",b", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })

-- Search (replaces ag.vim)
map("n", ",gg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", ",k", "<cmd>Telescope grep_string<cr>", { desc = "Grep word under cursor" })

-- NERDTree equivalent
map("n", "<C-\\>", "<cmd>Neotree reveal<cr>", { desc = "Reveal in tree" })

-- Git shortcuts
map("n", ",gb", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })
map("n", ",gl", "<cmd>Telescope git_commits<cr>", { desc = "Git log" })

-- Quick edit utilities
map("n", ",w", "<cmd>%s/\\s\\+$//e<cr>", { desc = "Strip whitespace" })

-- Window management (YADR style)
map("n", "vv", "<C-w>v", { desc = "Vertical split" })
map("n", "ss", "<C-w>s", { desc = "Horizontal split" })
map("n", "Q", "<cmd>close<cr>", { desc = "Close window" })

-- TODO: Add more YADR keymaps as you migrate from your vim setup
-- Examples to consider:
-- map("n", ",f", "<cmd>Telescope lsp_definitions<cr>", { desc = "Find definition" })
-- map("n", ",F", "<cmd>vsplit | Telescope lsp_definitions<cr>", { desc = "Find definition in split" })
-- map("n", ",,w", "<cmd>lua require('flash').jump()<cr>", { desc = "Flash jump" })
