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

# Remove
dockutil -r Launchpad
dockutil -r Maps
dockutil -r Photos
dockutil -r FaceTime
dockutil -r Contacts
dockutil -r Reminders
dockutil -r Freeform
dockutil -r TV
dockutil -r News
dockutil -r App\ Store
dockutil -r System\ Settings

# Add
dockutil -a file:///Applications/Ghostty.app/

# Move
dockutil -m Finder -p 0
dockutil -m Calendar -p 1
dockutil -m Safari -p 2
dockutil -m Google\ Chrome -p 3
dockutil -m Messages -p 4
dockutil -m Mail -p 5
dockutil -m Notes -p 6
dockutil -m Music -p 7
dockutil -m Ghostty -p 8



sudo shutdown -r now
