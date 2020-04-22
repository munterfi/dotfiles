# General
alias brew-update='brew update && brew upgrade && brew cleanup'
alias macos-update='sudo softwareupdate -i -a'
alias docker-start='open -a docker'
alias week='date +%V'
alias urlencode='python -c "import sys, urllib.parse as ulp; print(ulp.quote_plus(sys.argv[1]));"'
alias reload="exec ${SHELL} -l"
alias path='echo -e ${PATH//:/\\n}'

# Enable aliases to be sudo'ed
alias sudo='sudo '

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

# git
alias gs='git status -s'
alias gp='git pull'
alias gcm='git commit -m'
alias go='git checkout'
alias gom='git checkout master'
alias god='git checkout develop'
