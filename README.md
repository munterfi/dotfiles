# .files

This repo is a personal dotfile collection. For linking use:
``` bash
git clone https://github.com/munterfinger/dotfiles.git && cd "$_"
./link.sh
```

## macOS setup
Set up MBP on Catalina.

### homebrew

``` sh
# Install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Update all
brew update;brew upgrade;brew update;brew upgrade

# Packages
brew coreutils
brew install pkg-config
brew install grep
brew install wget
brew install tree
brew install curl
brew install pyenv
brew install gdal
brew install spatialindex
brew install pandoc
```

After installing homebrew pkgs, link the dotfiles.

### pyenv
Manage python versions.

``` bash
# Already added to .zshrc by linking
# Else: echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc

# Restart shell and install python
exec $SHELL
pyenv install 3.8.2
pyenv versions

# Set global
pyenv global 3.8.2
exec $SHELL

# Check environment
pyenv version
which python
python -V
which pip
pip -V
```

### Software
Avoid `brew cask install <PKG>`, install manually:

* Atom
* R (No binary packages from CRAN if installed via `brew install r`)
* RStudio
* PyCharm
* Docker Desktop
* VirtualBox
* Julia
* JupyterLab: IPKernel for R, Python and Julia (pip install)
* darktable
* Affinity
* Cyberduck
* QGIS

## Arch Linux
```sh
pacman -S base-devel zsh git vim geos gdal proj r julia
git clone https://github.com/munterfinger/dotfiles.git && cd "$_"
./link.sh
```

## Thanks to

* [managing-your-dotfiles](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/)
* [mathiasbynens](https://github.com/mathiasbynens/dotfiles)
* [anishathalye](https://github.com/anishathalye/dotbot)
* [jorisnoo](https://github.com/jorisnoo/dotfiles)
