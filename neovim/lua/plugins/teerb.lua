return {
  {
    "teerb",
    dir = vim.fn.stdpath("config"), -- Use local config
    name = "teerb",
    lazy = false,
    priority = 1000,
    config = function()
      require("teerb").setup({
        -- Configuration options
        transparent_background = false,
        terminal_colors = true,
        dim_inactive = {
          enabled = false,
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          keywords = { "italic" },
          -- Add more style customizations as needed
        },
        integrations = {
          treesitter = true,
          native_lsp = true,
          telescope = true,
          nvimtree = true,
          gitsigns = true,
          which_key = true,
          indent_blankline = true,
          -- Enable/disable integrations as needed
        },
      })
      
      -- Uncomment to set as default colorscheme
      -- vim.cmd.colorscheme("teerb")
    end,
  },
}
