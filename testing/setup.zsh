#! /bin/zsh

set -e

if [ ! -d "$HOME/.yadr" ]; then
    echo "Installing YADR for the first time"
    git clone --depth=1 -b neovim https://github.com/jinthagerman/dotfiles.git "$HOME/.yadr"
    cd "$HOME/.yadr"
    [ "$1" = "ask" ] && export ASK="true"
    rake install
else
    echo "YADR is already installed"
fi


~/.yadr/bin/macos

sudo shutdown -r now
