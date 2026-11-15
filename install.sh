#!/bin/sh
# Install: sh -c "$(curl -fsSL https://raw.githubusercontent.com/jinthagerman/dotfiles/neovim/install.sh)"
# Re-run any time; it only (re)creates symlinks and never touches real files.
set -e

YADR="$HOME/.yadr"
[ -d "$YADR" ] || git clone -b neovim https://github.com/jinthagerman/dotfiles.git "$YADR"
cd "$YADR"
git submodule update --init --recursive

link() { # link <repo path> <target>
  src="$YADR/$1"; dst="$2"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "skip  $dst (exists and is not a symlink; move it aside to link)"; return
  fi
  mkdir -p "$(dirname "$dst")"
  ln -sfn "$src" "$dst" && echo "link  $dst -> $src"
}

link zsh/prezto                    "$HOME/.zprezto"
for rc in zshenv zprofile zlogin zlogout; do
  link "zsh/prezto/runcoms/$rc"    "$HOME/.$rc"
done
link zsh/prezto-override/zshrc     "$HOME/.zshrc"
link zsh/prezto-override/zpreztorc "$HOME/.zpreztorc"
link git/gitconfig                 "$HOME/.gitconfig"
link git/gitignore                 "$HOME/.gitignore"
link vimify/inputrc                "$HOME/.inputrc"
link vimify/editrc                 "$HOME/.editrc"
link neovim                        "$HOME/.config/nvim"
link ghostty                       "$HOME/.config/ghostty"
link rex                           "$HOME/.config/rex"

# Per-machine git identity (not tracked, so work and personal machines differ).
# To change it later: rm ~/.gitconfig.user && ./install.sh
GITUSER="$HOME/.gitconfig.user"
if [ -f "$GITUSER" ]; then
  echo "git   identity: $(git config -f "$GITUSER" user.name) <$(git config -f "$GITUSER" user.email)> (from $GITUSER)"
else
  # GIT_NAME / GIT_EMAIL can be passed in to skip the prompts.
  name="$GIT_NAME" email="$GIT_EMAIL"
  if [ -z "$email" ] && (: < /dev/tty) 2>/dev/null; then
    printf "git name for this machine [Jin Budelmann]: " > /dev/tty; read -r name < /dev/tty
    printf "git email for this machine (e.g. jin@gd1.vc for work): " > /dev/tty; read -r email < /dev/tty
  fi
  if [ -n "$email" ]; then
    git config -f "$GITUSER" user.name "${name:-Jin Budelmann}"
    git config -f "$GITUSER" user.email "$email"
    echo "git   wrote $GITUSER: ${name:-Jin Budelmann} <$email>"
  else
    echo "warn  no git identity set; run: git config -f ~/.gitconfig.user user.email you@example.com"
  fi
fi

mkdir -p "$HOME/.zsh.after"
[ "$SHELL" = "$(command -v zsh)" ] || echo "note: run 'chsh -s $(command -v zsh)' to make zsh your login shell"
echo "done. Machine-local shell config goes in ~/.zsh.after/*.zsh and ~/.secrets"
