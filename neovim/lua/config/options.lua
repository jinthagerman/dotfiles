-- YADR-style options on top of LazyVim
local opt = vim.opt

opt.wrap = false
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.swapfile = false -- agents edit files under you; swap-file warnings just get in the way
opt.backup = false
opt.writebackup = false
opt.undofile = true

-- Agents edit files while they're open here. LazyVim only re-checks on focus or
-- terminal events, so also poll every second and reload unmodified buffers.
opt.autoread = true
local timer = vim.uv.new_timer()
timer:start(1000, 1000, vim.schedule_wrap(function()
  if vim.fn.mode() ~= "c" and vim.fn.getcmdwintype() == "" then
    vim.cmd("silent! checktime")
  end
end))
