# YADR Neovim Configuration

This directory contains a Neovim configuration that combines LazyVim with YADR-inspired customizations.

## Structure

```
neovim/
├── init.lua              # Main entry point - loads starter + custom configs
├── starter/              # LazyVim starter files (DO NOT MODIFY)
│   ├── init.lua         # LazyVim bootstrap
│   └── lua/config/      # LazyVim base configuration
├── lua/                 # Your YADR customizations
│   ├── config/          # Custom configuration files
│   │   ├── keymaps.lua  # YADR-style key mappings
│   │   └── options.lua  # YADR-style vim options
│   └── plugins/         # Custom plugin configurations
│       ├── yadr-features.lua  # Plugins that replicate YADR functionality
│       └── colorscheme.lua    # Custom Teerb theme
└── README.md            # This file
```

## What's What

### `starter/` Directory
Contains unmodified files from the [LazyVim starter](https://github.com/LazyVim/starter). 
**Do not modify these files** - they provide the base LazyVim functionality.

To update LazyVim starter:
1. Download latest starter files
2. Replace contents of `starter/` directory
3. Test that everything still works

### `lua/` Directory  
Contains your YADR-inspired customizations that extend/override the starter configuration.

**Safe to modify** - these are your personal customizations.

## Key Features

- **Custom Teerb colorscheme** - Migrated from your Ghostty theme
- **YADR-style keymaps** - Familiar shortcuts like `,t`, `,b`, `,gg`
- **YADR plugin equivalents** - Modern replacements for vim-fugitive, NERDTree, etc.
- **Language agnostic** - No Ruby bias, works with any language

## Installation

`~/.yadr/install.sh` symlinks this directory to `~/.config/nvim`.

## Usage

- Start with `nvim`
- Use `,t` for file finder (replaces CtrlP)
- Use `,gg` for live grep (replaces ag.vim)
- Use `<C-\>` to reveal file in the explorer (replaces NERDTree)
- Pickers use Snacks (LazyVim's default), not Telescope
- `,gs` lists changed files (handy for reviewing what an agent touched)
- `<leader>ac` toggles Claude Code (claudecode.nvim, enabled as a LazyVim extra in `lazyvim.json`)
- Buffers auto-reload every second when files change on disk (e.g. agent edits), unless you have unsaved changes

## Customization

Add your own plugins to `lua/plugins/` and keymaps to `lua/config/keymaps.lua`.
