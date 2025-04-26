#! /bin/bash

cd ..
git config user.name Dotfiliste
git config user.email dotfiliste@chezmoi
git config --add --local core.sshCommand 'ssh -i ~/.ssh/dotfiles'
git remote set-url origin git@github.com:dotfiliste/dotfiles.git
