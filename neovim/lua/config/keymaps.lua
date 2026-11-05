-- YADR-style keymaps on top of LazyVim (pickers use Snacks, LazyVim's default)
local map = vim.keymap.set

-- Buffers
map("n", ",z", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", ",x", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Pickers
map("n", ",t", function() Snacks.picker.files() end, { desc = "Find files" })
map("n", ",b", function() Snacks.picker.buffers() end, { desc = "Find buffers" })
map("n", ",gg", function() Snacks.picker.grep() end, { desc = "Live grep" })
map("n", ",k", function() Snacks.picker.grep_word() end, { desc = "Grep word under cursor" })
map("n", ",gb", function() Snacks.picker.git_branches() end, { desc = "Git branches" })
map("n", ",gl", function() Snacks.picker.git_log() end, { desc = "Git log" })
map("n", ",gs", function() Snacks.picker.git_status() end, { desc = "Git status (changed files)" })

-- File explorer
map("n", "<C-\\>", function() Snacks.explorer.reveal() end, { desc = "Reveal in explorer" })

-- Editing
map("n", ",w", "<cmd>%s/\\s\\+$//e<cr>", { desc = "Strip whitespace" })

-- Windows
map("n", "vv", "<C-w>v", { desc = "Vertical split" })
map("n", "ss", "<C-w>s", { desc = "Horizontal split" })
map("n", "Q", "<cmd>close<cr>", { desc = "Close window" })
