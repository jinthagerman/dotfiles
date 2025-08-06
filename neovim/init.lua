-- YADR Neovim Configuration
-- Combines LazyVim starter with YADR-inspired customizations

-- Load LazyVim starter configuration
-- Add the starter directory to the Lua path
vim.opt.runtimepath:prepend(vim.fn.stdpath("config") .. "/starter")
require("config.lazy")

-- Load our custom configurations
-- (These will override/extend the starter configs)
require("config.keymaps")
require("config.options")
