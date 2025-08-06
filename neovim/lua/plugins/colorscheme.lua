-- YADR-inspired colorschemes including custom Teerb theme

return {
  -- Your custom Teerb colorscheme (migrated from Ghostty)
  {
    "teerb-modified",
    dir = vim.fn.stdpath("config"),
    name = "teerb-modified", 
    lazy = false,
    priority = 1000,
    config = function()
      -- Define the colorscheme based on your Ghostty Teerb-modified theme
      local colors = {
        -- Terminal palette from your Ghostty config
        black = "#1c1c1c",        -- palette 0
        red = "#d68686",          -- palette 1
        green = "#aed686",        -- palette 2
        yellow = "#d7af87",       -- palette 3
        blue = "#86aed6",         -- palette 4
        magenta = "#d6aed6",      -- palette 5
        cyan = "#8adbb4",         -- palette 6
        white = "#d0d0d0",        -- palette 7
        
        -- Bright colors
        bright_black = "#888888", -- palette 8
        bright_red = "#d68686",   -- palette 9
        bright_green = "#aed686", -- palette 10
        bright_yellow = "#e4c9af", -- palette 11
        bright_blue = "#86aed6",  -- palette 12
        bright_magenta = "#d6aed6", -- palette 13
        bright_cyan = "#b1e7dd",  -- palette 14
        bright_white = "#efefef", -- palette 15
        
        -- UI colors from your config
        bg = "#262626",           -- background
        fg = "#d0d0d0",           -- foreground
        cursor = "#e4c9af",       -- cursor-color
        cursor_text = "#000000",  -- cursor-text
        selection_bg = "#4d4d4d", -- selection-background
        selection_fg = "#ffffff", -- selection-foreground
        
        -- Additional derived colors
        bg_dark = "#1c1c1c",
        bg_light = "#3a3a3a",
        fg_dark = "#888888",
        comment = "#888888",
        border = "#4d4d4d",
      }
      
      -- Create the colorscheme
      vim.cmd("hi clear")
      if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
      end
      
      vim.g.colors_name = "teerb-modified"
      vim.o.background = "dark"
      
      local function hi(group, opts)
        local cmd = "highlight " .. group
        if opts.fg then cmd = cmd .. " guifg=" .. opts.fg end
        if opts.bg then cmd = cmd .. " guibg=" .. opts.bg end
        if opts.style then cmd = cmd .. " gui=" .. opts.style end
        if opts.sp then cmd = cmd .. " guisp=" .. opts.sp end
        vim.cmd(cmd)
      end
      
      -- Basic UI
      hi("Normal", { fg = colors.fg, bg = colors.bg })
      hi("NormalFloat", { fg = colors.fg, bg = colors.bg_dark })
      hi("Cursor", { fg = colors.cursor_text, bg = colors.cursor })
      hi("CursorLine", { bg = colors.bg_light })
      hi("LineNr", { fg = colors.comment })
      hi("CursorLineNr", { fg = colors.bright_yellow })
      hi("Visual", { fg = colors.selection_fg, bg = colors.selection_bg })
      hi("Search", { fg = colors.black, bg = colors.bright_yellow })
      
      -- Syntax highlighting
      hi("Comment", { fg = colors.comment, style = "italic" })
      hi("Constant", { fg = colors.red })
      hi("String", { fg = colors.green })
      hi("Number", { fg = colors.red })
      hi("Boolean", { fg = colors.red })
      hi("Identifier", { fg = colors.blue })
      hi("Function", { fg = colors.yellow })
      hi("Statement", { fg = colors.magenta })
      hi("Keyword", { fg = colors.magenta, style = "italic" })
      hi("Type", { fg = colors.blue })
      hi("Special", { fg = colors.bright_cyan })
      hi("Error", { fg = colors.bright_red, bg = colors.bg })
      hi("Todo", { fg = colors.bright_yellow, bg = colors.bg, style = "bold" })
      
      -- Modern syntax highlighting (Tree-sitter)
      hi("@comment", { fg = colors.comment, style = "italic" })
      hi("@string", { fg = colors.green })
      hi("@number", { fg = colors.red })
      hi("@boolean", { fg = colors.red })
      hi("@function", { fg = colors.yellow })
      hi("@keyword", { fg = colors.magenta, style = "italic" })
      hi("@type", { fg = colors.blue })
      hi("@variable", { fg = colors.fg })
    end,
  },

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
      colorscheme = "teerb-modified", -- Your custom theme
      -- Alternatives: "kanagawa", "everforest"
    },
  },
}
