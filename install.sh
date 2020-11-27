#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Name          :install.sh
# Description   :Creates symbolic links from the 'dotfiles' repository location
#                to the home of the current user on macOS. If a dotfile or
#                directory already exists in the users home, the script prompts
#                for confirmation before deleting and replacing the file (or
#                or link) with a symbolic link.
# Author        :Merlin Unterfinger <info@munterfinger.ch>
# Date          :2020-05-17
# Version       :0.1.0
# Usage         :./install.sh
# Notes         :Only files and links will be deleted and replaced. If there
#                directories present in the users home, which should be
#                replaced by a symbolic link, delete them manually.
# Bash          :5.0.17(1)-release
# =============================================================================

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

confirm() {
  # Source: https://mike632t.wordpress.com/2017/07/06/bash-yes-no-prompt/
  local _prompt _default _response

  if [ "$1" ]; then _prompt="${1}"; else _prompt="Are you sure"; fi
  _prompt="${_prompt} [y/n] ?"

  # Loop forever until the user enters a valid response (Y/N or Yes/No)
  while true; do
    read -r -p "${_prompt} " _response
    case "${_response}" in
      [Yy][Ee][Ss]|[Yy]) # Yes or Y (case-insensitive)
        return 0
        ;;
      [Nn][Oo]|[Nn]) # No or N (case-insensitive)
        return 1
        ;;
      *) # Anything else (including a blank) is invalid
        ;;
    esac
  done
}

function lns_home () {
  echo "-> Linking: ${BASEDIR}/${1} <- ~/${1}"
  # Omit -rf flag as it throws an error if it is a directory (safer)
  ln -s "${BASEDIR}/${1}" "${HOME}/${1}"
}

function create_link() {
  local filename="${1}"
  echo "Configure: '~/${filename}'"

  # Check if directory and not symbolic link to a directory exists
  if [ -d "${HOME}/${filename}" ] && [ ! -h "${HOME}/${filename}" ]; then
    echo -e "-> Warning: Directory '~/${filename}' already exists.
   Please check directory content and remove manually."
    echo "-> Linking: '~/${filename}' skipped."
  else
    # Check if file, link to a file or link to a directory exists
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
create_link .zshenv
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

# R
create_link .R/Makevars

# git
# create_link .gitconfig
# create_link .gitignore

# Restart SHELL
exec $SHELL
