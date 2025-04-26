#! /bin/bash

cd $CHEZMOI_SOURCE_DIR
git config user.name Dotfiliste
git config user.email dotfiliste@chezmoi
git config --add --local core.sshCommand 'ssh -i ~/.ssh/dotfiles'
git remote set-url origin github.com:dotfiliste/dotfiles.git
