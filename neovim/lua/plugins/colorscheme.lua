-- YADR-inspired colorschemes including custom Teerb theme

return {
  -- Alternative colorschemes (similar aesthetic to Teerb)
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 999,
    opts = {
      commentStyle = { italic = true },
      keywordStyle = { italic = true },
      terminalColors = true,
      theme = "wave",
    },
  },

  {
    "sainnhe/everforest",
    lazy = false,
    priority = 998,
    config = function()
      vim.g.everforest_background = "medium"
      vim.g.everforest_enable_italic = 1
    end,
  },

  -- Configure LazyVim to use your custom Teerb theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "teerb", -- Your custom theme (now in colors/ directory)
      -- Alternatives: "kanagawa", "everforest"
    },
  },
}
