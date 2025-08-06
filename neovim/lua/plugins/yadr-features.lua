-- YADR-inspired plugins
-- These add functionality that replicates key YADR features

return {
  -- Enhanced Git Integration (replaces vim-fugitive features)
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
    },
  },

  -- Multiple cursors (replaces vim-multiple-cursors)
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-n>",
        ["Find Subword Under"] = "<C-n>",
      }
    end,
  },

  -- Enhanced search and replace (replaces greplace.vim)
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },

  -- Split/Join (replaces splitjoin.vim)
  {
    "Wansmer/treesj",
    keys = {
      { "gS", "<cmd>TSJSplit<cr>", desc = "Split" },
      { "gJ", "<cmd>TSJJoin<cr>", desc = "Join" },
    },
    opts = { use_default_keymaps = false },
  },

  -- Tmux navigation (replaces vim-tmux-navigator)
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    },
  },

  -- Color highlighting (replaces color_highlight)
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("colorizer").setup({
        "*", -- Highlight all files
        css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css
        html = { names = false }, -- Disable parsing "names" like Blue or Gray
      })
    end,
  },

  -- Markdown preview (replaces vim-markdown-preview)
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
    },
  },

  -- Enhanced text objects (replaces targets.vim)
  {
    "wellle/targets.vim",
    event = "VeryLazy",
  },

  -- TODO: Add more plugins as you identify missing YADR functionality
  -- Examples to consider:
  -- - vim-abolish for smart search/replace
  -- - gundo.vim for undo tree visualization  
  -- - vim-unimpaired for bracket mappings
}
