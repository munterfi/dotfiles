#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# vim
echo "Linking: $BASEDIR/.vimrc <- ~/.vimrc"
ln -s ${BASEDIR}/.vimrc ~/.vimrc
echo "Linking: $BASEDIR/.vim <- ~/.vim"
ln -s ${BASEDIR}/.vim/ ~/.vim

# zsh
echo "Linking: $BASEDIR/.zshrc <- ~/.zshrc"
ln -s ${BASEDIR}/.zshrc ~/.zshrc
echo "Linking: $BASEDIR/.zsh <- ~/.zsh"
ln -s ${BASEDIR}/.zsh ~/.zsh

# git
#echo "Linking: $BASEDIR/.gitconfig <- ~/.gitconfig"
#ln -s ${BASEDIR}/.gitconfig ~/.gitconfig
#echo "Linking: $BASEDIR/.gitignore <- ~/.gitignore"
#ln -s ${BASEDIR}/.gitignore ~/.gitignore
