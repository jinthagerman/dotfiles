tart pull ghcr.io/cirruslabs/macos-sequoia-base:latest
tart clone ghcr.io/cirruslabs/macos-sequoia-base:latest test
tart run --dir=host:scripts test


#!/bin/sh

if [ ! -d "$HOME/.yadr" ]; then
    echo "Installing YADR for the first time"
    git clone --depth=1 -b <branch> https://github.com/jinthagerman/dotfiles.git "$HOME/.yadr"
    cd "$HOME/.yadr"
    [ "$1" = "ask" ] && export ASK="true"
    rake install
else
    echo "YADR is already installed"
fi

~/.yadr/bin/macos