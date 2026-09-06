#! /bin/bash

which brew
if [ "$?" != 0 ]
then
    echo "$0: homebrew not found, installing"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
echo "$0: homebrew found, installing dependencies"

brew bundle --file=/dev/stdin <<EOF
brew "fzf"
brew "keychain"
brew "neovim"
brew "pure"
brew "zoxide"
EOF
