#!/bin/sh

ln -nfs `pwd`/gitconfig ~/.gitconfig
ln -nfs `pwd`/gitignore_global ~/.gitignore_global
ln -nfs `pwd`/irbrc ~/.irbrc
ln -nfs `pwd`/zshrc ~/.zshrc
ln -nfs `pwd`/tmux.conf ~/.tmux.conf

mkdir -p ~/.lein
ln -nfs `pwd`/lein/profiles.clj ~/.lein/profiles.clj
