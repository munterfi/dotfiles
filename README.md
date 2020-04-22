# .files

## macOS setup
Set up MBP on Catalina.

### homebrew

``` sh
# Install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Update all
brew update;brew upgrade;brew update;brew upgrade

# Packages
? brew 'coreutils'
?brew install grep
brew install wget
brew install tree
? brew install curl
brew install pkg-config
brew install gdal
brew install spatialindex
brew install pandoc
```


### pyenv
Manage python versions.

``` bash
brew install pyenv
# Add to .zshtc or .bash_profile
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc

# Restart shell and install python
exec $SHELL
pyenv install 3.8.2
pyenv versions

# Set global
pyenv global 3.8.2
exec $SHELL

# check environment
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
pacman -S zsh
```
