#! /bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew bundle --file=/dev/stdin <<EOF
brew "fzf"
brew "keychain"
brew "neovim"
brew "pure"
brew "zoxide"
brew "font-jetbrains-mono-nerd-font"
EOF
