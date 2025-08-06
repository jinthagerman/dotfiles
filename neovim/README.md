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
│       └── colorscheme.lua    # Custom Teerb theme + alternatives
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

This is installed automatically when you run `rake install` and choose to install Neovim configuration.

## Usage

- Start with `nvim`
- Use `,t` for file finder (replaces CtrlP)
- Use `,gg` for live grep (replaces ag.vim)
- Use `<C-\>` to reveal file in tree (replaces NERDTree)
- Switch colorschemes with `:colorscheme kanagawa` or `:colorscheme everforest`

## Customization

Add your own plugins to `lua/plugins/` and keymaps to `lua/config/keymaps.lua`.
