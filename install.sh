#!/usr/bin/env bash
############################################################
#  Create symbolic links to the dotfiles on macOS          #
#  Version: 0.1.0                                          #
#  File: ~/install.sh                                      #
#                                                          #
#  -------------------------------------------------       #
#  This script creates symbolic links from the dotfile     #
#  locations in this local repository to the home dir      #
#  of the current user. If a dotfile or folder already     #
#  exists in the users home dir, the script prompts for    #
#  deleting and replacing the file/link with a symbolic    #
#  link.                                                   #
#  Note: Only files and links will be deleted. If there    #
#  are folders present in the home dir, which should be    #
#  replaced by a symbolic link, delete them manually.      #
#                                                          #
#  Setup:                                                  #
#     $ git clone https://github.com/munterfinger/dotfiles #
#     $ cd dotfiles                                        #
#                                                          #
#  Usage:                                                  #
#     $ ./install.sh                                       #
#                                                          #
#  GNU General Public License 3.0 - by Merlin Unterfinger  #
############################################################

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

confirm() {
  # Source: https://mike632t.wordpress.com/2017/07/06/bash-yes-no-prompt/
  local _prompt _default _response

  if [ "$1" ]; then _prompt="${1}"; else _prompt="Are you sure"; fi
  _prompt="${_prompt} [y/n] ?"

  # Loop forever until the user enters a valid response (Y/N or Yes/No).
  while true; do
    read -r -p "${_prompt} " _response
    case "${_response}" in
      [Yy][Ee][Ss]|[Yy]) # Yes or Y (case-insensitive).
        return 0
        ;;
      [Nn][Oo]|[Nn])  # No or N.
        return 1
        ;;
      *) # Anything else (including a blank) is invalid.
        ;;
    esac
  done
}

function lns_home () {
  echo "-> Linking: ${BASEDIR}/${1} <- ~/${1}"
  # Omit -rf  as it throws an error if a directory (safer).
  ln -s "${BASEDIR}/${1}" "${HOME}/${1}"
}

function create_link() {
  local filename="${1}"
  echo "Configure: '~/${filename}'"

  # Check if directory and not symbolic link to a directory exists.
  if [ -d "${HOME}/${filename}" ] && [ ! -h "${HOME}/${filename}" ]; then
    echo -e "-> Warning: Directory '~/${filename}' already exists.
   Please check directory content and remove manually."
    echo "-> Linking: '~/${filename}' skipped."
  else
    # Check if file, link to a file or link to a directory exists.
    if [ -f "${HOME}/${filename}" ] || [ -d "${HOME}/${filename}" ]; then
      # Remove and replace?
      echo "-> Warning: File or link '~/${filename}' already exists."
      if confirm "   Replace with a symbolic link?"; then
        rm "${HOME}/${filename}"
        lns_home "${filename}"
      else
        echo "-> Linking: '~/${filename}' skipped."
      fi
    else
      lns_home "${filename}"
    fi
  fi
}

# Create the symbolic links: Add manually, do not use loops!
# bin
create_link bin

# zsh
create_link .zshrc
create_link .zsh

# bash
create_link .bash_profile

# vim
create_link .vimrc
create_link .vim

# starship
create_link .config/starship.toml

# hyper
create_link .hyper.js

# git
# create_link .gitconfig
# create_link .gitignore

# Restart SHELL
exec $SHELL
