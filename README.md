# .files

This repository is a personal dotfile collection. For linking use:
``` bash
git clone https://github.com/munterfinger/dotfiles.git && cd "$_"
./install.sh
```

... or create the symbolic links manually (e.g. `ln -s <repository-path>/.zshrc ~/.zshrc`).

## macOS setup
Set up on macOS Catalina.

### Homebrew
``` sh
# Install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Update all
brew update; brew upgrade; brew cleanup

# Packages
brew install "$(<pkg/brewlist.txt)"
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

# Packages
pip install -r pkg/piplist.txt
```

### R
Install latest R version directly from [CRAN](https://cloud.r-project.org). No binary packages from CRAN are available if installed via `brew install r`. Then install packages:

``` bash
Rscript -e 'install.packages(read.table("pkg/rlist.txt")[[1]], repo="https://cran.rstudio.com/")'
```

### Applications
Avoid `brew cask install <PKG>`, install manually:

* Atom
* LuLu
* RStudio
* PyCharm
* Postman
* Docker Desktop
* VirtualBox
* Julia
* ImageOptim
* JupyterLab: IPKernel for R, Python and Julia (pip install)
* darktable
* Affinity Photo
* Cyberduck
* QGIS
* VLC

## Arch Linux

Some paths have to be adjusted (e.g. julia) and some macOS specific alias should be commented out.
Check the files manually before linking. Hint: Use `en_DK.UTF-8` in `.zsh/zshenv.zsh`.

```sh
pacman -S base-devel zsh git vim geos gdal proj r julia
git clone https://github.com/munterfinger/dotfiles.git && cd "$_"
./install.sh
```

## Thanks to

* [managing-your-dotfiles](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/)
* [jummidark](https://github.com/jcherven/jummidark.vim) color theme for Vim
* [mathiasbynens](https://github.com/mathiasbynens/dotfiles)
* [anishathalye](https://github.com/anishathalye/dotfiles)
* [jorisnoo](https://github.com/jorisnoo/dotfiles)
