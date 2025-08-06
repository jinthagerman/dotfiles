local M = {}

-- Helper function to merge styles
local function merge_styles(styles)
  if not styles or #styles == 0 then
    return {}
  end
  
  local result = {}
  for _, style in ipairs(styles) do
    if style == "bold" then
      result.bold = true
    elseif style == "italic" then
      result.italic = true
    elseif style == "underline" then
      result.underline = true
    elseif style == "strikethrough" then
      result.strikethrough = true
    end
  end
  return result
end

function M.setup(palette, options)
  local theme = {}
  
  -- Determine background based on transparency option
  local bg = options.transparent_background and palette.none or palette.bg
  local bg_dark = options.transparent_background and palette.none or palette.bg_dark
  
  -- Basic UI
  theme.Normal = { fg = palette.fg, bg = bg }
  theme.NormalFloat = { fg = palette.fg, bg = bg_dark }
  theme.NormalNC = options.dim_inactive.enabled and { 
    fg = palette.fg, 
    bg = palette.bg_dark 
  } or theme.Normal
  
  theme.Cursor = { fg = palette.cursor_text, bg = palette.cursor }
  theme.CursorLine = { bg = palette.bg_light }
  theme.CursorColumn = { bg = palette.bg_light }
  theme.LineNr = { fg = palette.comment }
  theme.CursorLineNr = { fg = palette.bright_yellow, bold = not options.no_bold }
  theme.Visual = { fg = palette.selection_fg, bg = palette.selection_bg }
  theme.Search = { fg = palette.black, bg = palette.bright_yellow }
  theme.IncSearch = { fg = palette.black, bg = palette.bright_yellow }
  theme.Substitute = { fg = palette.black, bg = palette.bright_yellow }
  
  -- Status and splits
  theme.StatusLine = { fg = palette.fg, bg = palette.bg_light }
  theme.StatusLineNC = { fg = palette.comment, bg = bg_dark }
  theme.VertSplit = { fg = palette.border }
  theme.WinSeparator = { fg = palette.border }
  
  -- Popups and menus
  theme.Pmenu = { fg = palette.fg, bg = bg_dark }
  theme.PmenuSel = { fg = palette.selection_fg, bg = palette.selection_bg }
  theme.PmenuSbar = { bg = palette.bg_light }
  theme.PmenuThumb = { bg = palette.comment }
  
  -- Folding
  theme.Folded = { fg = palette.comment, bg = palette.bg_light }
  theme.FoldColumn = { fg = palette.comment }
  
  -- Diff
  theme.DiffAdd = { bg = palette.green, fg = palette.black }
  theme.DiffChange = { bg = palette.yellow, fg = palette.black }
  theme.DiffDelete = { bg = palette.red, fg = palette.black }
  theme.DiffText = { bg = palette.bright_yellow, fg = palette.black }
  
  -- Messages
  theme.ErrorMsg = { fg = palette.error, bold = not options.no_bold }
  theme.WarningMsg = { fg = palette.warning, bold = not options.no_bold }
  theme.MoreMsg = { fg = palette.info }
  theme.Question = { fg = palette.info }
  
  -- Syntax highlighting
  local syntax_styles = options.styles
  
  theme.Comment = vim.tbl_extend("force", 
    { fg = palette.comment }, 
    merge_styles(syntax_styles.comments)
  )
  
  theme.Constant = { fg = palette.red }
  theme.String = vim.tbl_extend("force", 
    { fg = palette.green }, 
    merge_styles(syntax_styles.strings)
  )
  theme.Number = vim.tbl_extend("force", 
    { fg = palette.red }, 
    merge_styles(syntax_styles.numbers)
  )
  theme.Boolean = vim.tbl_extend("force", 
    { fg = palette.red }, 
    merge_styles(syntax_styles.booleans)
  )
  
  theme.Identifier = { fg = palette.blue }
  theme.Function = vim.tbl_extend("force", 
    { fg = palette.yellow }, 
    merge_styles(syntax_styles.functions)
  )
  
  theme.Statement = { fg = palette.magenta }
  theme.Keyword = vim.tbl_extend("force", 
    { fg = palette.magenta }, 
    merge_styles(syntax_styles.keywords)
  )
  theme.Conditional = vim.tbl_extend("force", 
    { fg = palette.magenta }, 
    merge_styles(syntax_styles.conditionals)
  )
  theme.Repeat = vim.tbl_extend("force", 
    { fg = palette.magenta }, 
    merge_styles(syntax_styles.loops)
  )
  
  theme.Type = vim.tbl_extend("force", 
    { fg = palette.blue }, 
    merge_styles(syntax_styles.types)
  )
  theme.Special = { fg = palette.bright_cyan }
  theme.Operator = vim.tbl_extend("force", 
    { fg = palette.magenta }, 
    merge_styles(syntax_styles.operators)
  )
  
  theme.Error = { fg = palette.bright_red, bg = bg }
  theme.Todo = { fg = palette.bright_yellow, bg = bg, bold = not options.no_bold }
  
  -- Tree-sitter highlights
  if options.integrations.treesitter then
    theme["@comment"] = theme.Comment
    theme["@string"] = theme.String
    theme["@number"] = theme.Number
    theme["@boolean"] = theme.Boolean
    theme["@function"] = theme.Function
    theme["@keyword"] = theme.Keyword
    theme["@conditional"] = theme.Conditional
    theme["@repeat"] = theme.Repeat
    theme["@type"] = theme.Type
    theme["@variable"] = vim.tbl_extend("force", 
      { fg = palette.fg }, 
      merge_styles(syntax_styles.variables)
    )
    theme["@parameter"] = { fg = palette.fg }
    theme["@property"] = vim.tbl_extend("force", 
      { fg = palette.blue }, 
      merge_styles(syntax_styles.properties)
    )
    theme["@operator"] = theme.Operator
    theme["@punctuation"] = { fg = palette.fg }
    theme["@tag"] = { fg = palette.red }
    theme["@tag.attribute"] = { fg = palette.yellow }
    theme["@tag.delimiter"] = { fg = palette.fg }
  end
  
  -- LSP highlights
  local lsp_enabled = options.integrations.native_lsp
  if lsp_enabled then
    theme.DiagnosticError = { fg = palette.error }
    theme.DiagnosticWarn = { fg = palette.warning }
    theme.DiagnosticInfo = { fg = palette.info }
    theme.DiagnosticHint = { fg = palette.hint }
    
    -- Handle native_lsp as boolean or table
    local lsp_config = type(lsp_enabled) == "table" and lsp_enabled or {}
    
    -- Virtual text
    local vt = lsp_config.virtual_text or {}
    theme.DiagnosticVirtualTextError = vim.tbl_extend("force", 
      { fg = palette.error }, 
      merge_styles(vt.errors or {})
    )
    theme.DiagnosticVirtualTextWarn = vim.tbl_extend("force", 
      { fg = palette.warning }, 
      merge_styles(vt.warnings or {})
    )
    theme.DiagnosticVirtualTextInfo = vim.tbl_extend("force", 
      { fg = palette.info }, 
      merge_styles(vt.information or {})
    )
    theme.DiagnosticVirtualTextHint = vim.tbl_extend("force", 
      { fg = palette.hint }, 
      merge_styles(vt.hints or {})
    )
    
    -- Underlines
    local ul = lsp_config.underlines or {}
    theme.DiagnosticUnderlineError = merge_styles(ul.errors or { "underline" })
    theme.DiagnosticUnderlineWarn = merge_styles(ul.warnings or { "underline" })
    theme.DiagnosticUnderlineInfo = merge_styles(ul.information or { "underline" })
    theme.DiagnosticUnderlineHint = merge_styles(ul.hints or { "underline" })
  end
  
  -- Git signs
  if options.integrations.gitsigns then
    theme.GitSignsAdd = { fg = palette.git_add }
    theme.GitSignsChange = { fg = palette.git_change }
    theme.GitSignsDelete = { fg = palette.git_delete }
  end
  
  -- Telescope
  if options.integrations.telescope then
    theme.TelescopeNormal = { fg = palette.fg, bg = bg_dark }
    theme.TelescopeBorder = { fg = palette.border }
    theme.TelescopePromptBorder = { fg = palette.border }
    theme.TelescopeResultsBorder = { fg = palette.border }
    theme.TelescopePreviewBorder = { fg = palette.border }
    theme.TelescopeSelection = { fg = palette.selection_fg, bg = palette.selection_bg }
    theme.TelescopeSelectionCaret = { fg = palette.bright_yellow }
  end
  
  -- Which-key
  if options.integrations.which_key then
    theme.WhichKey = { fg = palette.bright_cyan }
    theme.WhichKeyGroup = { fg = palette.blue }
    theme.WhichKeyDesc = { fg = palette.fg }
    theme.WhichKeySeperator = { fg = palette.comment }
    theme.WhichKeyFloat = { bg = bg_dark }
    theme.WhichKeyBorder = { fg = palette.border }
  end
  
  -- Indent blankline
  if options.integrations.indent_blankline then
    theme.IndentBlanklineChar = { fg = palette.bg_light }
    theme.IndentBlanklineContextChar = { fg = palette.comment }
  end
  
  return theme
end

return M
