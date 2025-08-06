-- Enhanced Teerb colorscheme for Neovim
-- Based on the Ghostty Teerb-modified theme

local M = {
  default_options = {
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
      loops = {},
      functions = {},
      keywords = { "italic" },
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
      telescope = true,
      nvimtree = true,
      gitsigns = true,
      which_key = true,
      indent_blankline = true,
      dashboard = true,
      bufferline = true,
      markdown = true,
      notify = true,
      mini = true,
    },
  },
}

local options = M.default_options

function M.setup(opts)
  options = vim.tbl_deep_extend("force", M.default_options, opts or {})
end

function M.load()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "teerb"

  local palette = require("teerb.palette")
  local theme = require("teerb.theme").setup(palette, options)
  
  -- Apply highlights
  for group, color in pairs(theme) do
    vim.api.nvim_set_hl(0, group, color)
  end

  -- Set terminal colors if enabled
  if options.terminal_colors then
    require("teerb.terminal").setup(palette)
  end
end

return M
