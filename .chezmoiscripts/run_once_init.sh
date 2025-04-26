#! /bin/bash

chezmoi cd
git config user.name Dotfiliste
git config user.email dotfiliste@chezmoi
git config --add --local core.sshCommand 'ssh -i ~/.ssh/dotfiles'
