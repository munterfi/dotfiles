# General
alias brew-update='brew update && brew upgrade && brew cleanup'
alias macos-update='sudo softwareupdate -i -a'
alias week='date +%V'
alias urlencode='python -c "import sys, urllib.parse as ulp; print(ulp.quote_plus(sys.argv[1]));"'
alias reload="exec ${SHELL} -l"
alias path='echo -e ${PATH//:/\\n}'
alias grep='grep --color=auto'
alias ssh-pub='(pbcopy < ~/.ssh/id_rsa.pub; echo "Copied SSH Key to clipboard.")'
alias o='open .'

# Python
alias pydev-update='python -m pip install --upgrade pip setuptools wheel twine'
alias pydev-build='python setup.py sdist bdist_wheel'
alias pydev-upload-testenv='python -m twine upload --repository testpypi dist/*'
alias pydev-upload='python -m twine dist/*'

# Enable aliases to be sudo'ed
alias sudo='sudo '

# Kubernetes
alias k='kubectl'
alias k-start='minikube start'
alias k-stop='minikube stop'

# Show/hide hidden files in Finder
alias show='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hide='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
alias showdesktop='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ip-local="ipconfig getifaddr en0"
alias ip-ls="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Navigate
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'
alias dl='cd ~/Downloads'
alias dt='cd ~/Desktop'
alias re='cd ~/repos'

# ls
alias l='ls'
alias la='ls -a'
alias lla='ls -la'

# docker
alias docker-cleanup='docker system prune --volumes --force'
alias docker-stop='osascript -e "quit app \"Docker\""'

# git
alias gs='git status -s'
alias gd='git diff --stat'
alias gp='git pull'
alias gup='git push'
alias ga='git add'
alias gaa='git add .'
alias gau='git add -u'
alias gcm='git commit -m'
alias gcsm='git commit -s -m'
alias go='git checkout'
alias gom='git checkout master'
alias god='git checkout develop'
alias gba='git branch -avv'
alias glog='git log --graph --date=iso --pretty=format:"%C(auto)%h%x09%<(4,trunc)%an %C(#D3D3D3)%<(18,trunc)%ad%C(reset) %C(red)%d%C(reset) %s"'
alias grank='git shortlog -sn --no-merges'
