# .files

This repository is a personal dotfile collection. For linking use:

``` bash
git clone https://github.com/munterfinger/dotfiles.git && cd "$_"
./install.sh
```

... or create the symbolic links manually (e.g. `ln -s <repository-path>/.zshrc ~/.zshrc` ).

## macOS setup

Set up on macOS Big Sur.

### Homebrew

``` sh
# Install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Update all
brew update; brew upgrade; brew cleanup

# Packages
brew install "$(<pkg/brewlist.txt)"
```

After installing homebrew pkgs, link the dotfiles using `./install.sh` .
For a proper display of icons download and install [Fibra Code NF](https://www.nerdfonts.com/font-downloads).

### pyenv

Manage python versions.

``` bash
# Already added to .zshrc by linking
# Else: echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc

# List all version available to pyenv
pyenv install --list

# Use pyenv wrapper pyset to set global version
pyset -U -r pkg/piplist.txt <version>

# Tell poetry which version to use
# (Bug: Uses homebrew python instead global pyenv version)
poetry env use <python-version>
```

### R

Install latest R version directly from [CRAN](https://cloud.r-project.org). No binary packages from CRAN are available if installed via `brew install r` . Then install packages:

``` bash
Rscript -e 'install.packages(read.table("pkg/rlist.txt")[[1]], repo="https://cran.rstudio.com/")'

# Configure for JupyterLab:
Rscript -e 'devtools::install_github("IRkernel/IRkernel")'
Rscript -e 'IRkernel::installspec()'
```

### Applications

Avoid `brew cask install <PKG>` , install manually:

* Hyper
* Atom
* LuLu
* RStudio
* PyCharm
* pgAdmin4
* Postman
* Docker Desktop
* VirtualBox
* Julia
* ImageOptim
* JupyterLab: IPKernel for R, Python and Julia (pip install)
* darktable
* Affinity Designer
* Affinity Photo
* Cyberduck
* QGIS
* VLC
* Visual Studio Code

Set Google style code formatting for C++ in vscode:

``` sh
# macOS
vim "$HOME/Library/Application Support/Code/User/settings.json"
# Linux
vim $HOME/.config/Code/User/settings.json

# Insert line:
{
  ...,
  "C_Cpp.clang_format_fallbackStyle": "{ BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 0}",
  ...
}
````

### SSH

Copy existing keys into `.ssh` or generate a new one and add the key to the
ssh-agent to prevent from the need of entering the key's passphrase after
restarts of the machine (see `.ssh/config` file).

## Arch Linux / CentOS

Some paths have to be adjusted (e.g. julia) and some macOS specific alias should be commented out.
Check the files manually before linking. Hint: Use `en_DK.UTF-8` in `.zshenv` .

``` sh
pacman -S base-devel zsh git vim geos gdal proj r julia # or: dnf install
git clone https://github.com/munterfinger/dotfiles.git && cd "$_"
./install.sh
```

## Thanks to

* [managing-your-dotfiles](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/)
* [jummidark](https://github.com/jcherven/jummidark.vim) color theme for Vim
* [mathiasbynens](https://github.com/mathiasbynens/dotfiles)
* [anishathalye](https://github.com/anishathalye/dotfiles)
* [jorisnoo](https://github.com/jorisnoo/dotfiles)
