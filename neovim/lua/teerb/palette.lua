-- Teerb color palette
-- Based on your Ghostty config

return {
  -- Terminal palette
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
  
  -- UI colors
  bg = "#262626",           -- background
  fg = "#d0d0d0",           -- foreground
  cursor = "#e4c9af",       -- cursor-color
  cursor_text = "#000000",  -- cursor-text
  selection_bg = "#4d4d4d", -- selection-background
  selection_fg = "#ffffff", -- selection-foreground
  
  -- Additional derived colors for better UI
  bg_dark = "#1c1c1c",
  bg_light = "#3a3a3a",
  bg_lighter = "#4d4d4d",
  fg_dark = "#888888",
  fg_light = "#efefef",
  comment = "#888888",
  border = "#4d4d4d",
  
  -- Semantic colors
  error = "#d68686",
  warning = "#e4c9af",
  info = "#86aed6",
  hint = "#b1e7dd",
  
  -- Git colors
  git_add = "#aed686",
  git_change = "#d7af87",
  git_delete = "#d68686",
  
  -- Special
  none = "NONE",
}
