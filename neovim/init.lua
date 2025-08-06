-- YADR Neovim Configuration
-- Combines LazyVim starter with YADR-inspired customizations

-- Load LazyVim starter configuration
require("starter.config.lazy")

-- Load our custom configurations
-- (These will override/extend the starter configs)
require("config.keymaps")
require("config.options")
