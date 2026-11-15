# dotfiles

Personal macOS dotfiles (forked long ago from YADR), trimmed for agentic coding:
Ghostty + zsh/Prezto + LazyVim, with Claude Code / Codex doing most of the typing.

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/jinthagerman/dotfiles/neovim/install.sh)"
```

`install.sh` is idempotent: it inits the Prezto submodule, symlinks everything
(never overwriting real files), and sets this machine's git identity.

**Git identity** lives in untracked `~/.gitconfig.user`, so work and personal
machines can differ. On first run the installer prompts for name and email; to
skip the prompt pass `GIT_EMAIL=you@example.com` (and optionally `GIT_NAME=...`).
To change it later: `rm ~/.gitconfig.user && ~/.yadr/install.sh`.

## Layout

| Path | Linked to | Notes |
| --- | --- | --- |
| `zsh/prezto-override/zshrc` | `~/.zshrc` | Loads Prezto, then `zsh/*.zsh`, then tool integrations |
| `zsh/prezto-override/zpreztorc` | `~/.zpreztorc` | Prezto modules, vi mode, `kylewest` prompt |
| `zsh/*.zsh` | | `00_env` (EDITOR, PATH), `aliases` (+ `wt` worktree helper), key bindings |
| `git/gitconfig`, `git/gitignore` | `~/.gitconfig`, `~/.gitignore` | identity comes from `~/.gitconfig.user` |
| `neovim/` | `~/.config/nvim` | LazyVim + Teerb theme + claudecode.nvim (`<leader>ac`) |
| `ghostty/` | `~/.config/ghostty` | |
| `rex/` | `~/.config/rex` | Rex: agent actions + keys; app settings via `rex/settings` (below) |
| `vimify/` | `~/.inputrc`, `~/.editrc` | vi mode for readline/libedit REPLs |

Machine-local, untracked: `~/.zsh.after/*.zsh`, `~/.secrets` (sourced if present), `~/.gitconfig.user`.

## Agent shells

When `CLAUDECODE`, `CODEX_SANDBOX` or `AGENT` is set (Claude Code's tool shell and
`!` mode, Codex), the shell sets `YADR_AGENT_SHELL=1` and skips anything that changes how
standard commands behave: Prezto's `cp -i`/`mv -i`/`rm -i`, `noglob git`, and
global aliases. Shortcut aliases (`gs`, `gd`, `ll`, `vim`→`nvim`, …) still load.
To mark another agent's shell, export `AGENT=1` in it.

## Worktrees for parallel agents

```sh
wt fix-login        # ~/Code/app -> ~/Code/app-worktrees/fix-login (new branch from HEAD)
wt feat-x main      # branch from main
wtrm                # remove the current worktree, cd back to the main checkout
```

New branches push without `-u` (`push.autoSetupRemote`).

## Rex agent actions

Defined in `rex/init.lua`; also in the command palette under **Agents**.

| Key | Action |
| --- | --- |
| `shift+cmd+c` | **Claude Here**: split right, start `claude` in the focused pane's directory |
| `shift+cmd+t` | **New Agent Worktree Tab**: new tab in the same repo with `wt ` typed, ready for a branch name |
| `shift+cmd+j` | **Jump to Waiting Agent**: cycle through panes whose agent is blocked on you, then ones that finished |
| `shift+cmd+r` | **Review Changes**: split below with Neovim's changed-files picker |
| `shift+cmd+f` | **Scratch Shell**: floating shell in the same directory |

After editing: `rex config check && rex config reload`. Try an action from the
file before reloading with `rex do rex/init.lua --action <name>`.

### Rex app settings

Theme (incl. custom themes), fonts, sidebar, tab and pane options are set in the
app and stored in macOS preferences, so they're synced by copy instead of symlink:

```sh
rex/settings save    # after changing settings in the app; then commit rex/settings.json
rex/settings load    # apply the repo's settings (quit Rex first)
```

`install.sh` loads them automatically only on a machine with no Rex settings yet.
