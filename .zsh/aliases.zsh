# ==============================================================================
#  General & System
# ==============================================================================
alias brew-update='brew update && brew upgrade && brew cleanup'
alias macos-update='sudo softwareupdate -i -a'
alias reload="exec ${SHELL} -l"
alias sudo='sudo ' # Enables aliases to be sudo'ed

# Utilities
alias week='date +%V'
alias ssh-pub='pbcopy < ~/.ssh/id_ed25519.pub && echo "✔ Copied ~/.ssh/id_ed25519.pub to clipboard."'
alias ip-ext="dig +short myip.opendns.com @resolver1.opendns.com"
alias ip-local="ipconfig getifaddr en0"
alias o='open .'

# Print PATH one entry per line
alias path='echo $PATH | tr ":" "\n"'

# ==============================================================================
#  UI & Finder
# ==============================================================================
# Show/hide hidden files in Finder
alias hidden-show='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hidden-hide='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'

# Hide/show all desktop icons
# Note: FALSE = Hide icons, TRUE = Show icons
alias desktop-hide='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
alias desktop-show='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'

# ==============================================================================
#  Navigation & Safety
# ==============================================================================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

# ==============================================================================
#  Modern Replacements
# ==============================================================================
# ls -> eza
alias ls='eza --icons --group-directories-first'
alias l='eza -1 --icons --group-directories-first'
alias ll='eza -l --icons --git --group-directories-first'
alias la='eza -la --icons --git --group-directories-first'
alias tree='eza --tree --icons'

# grep -> ripgrep
alias grep='rg'

# ==============================================================================
#  Git
# ==============================================================================
alias gs='git status -s'
alias ga='git add'
alias gaa='git add .'
alias gau='git add -u'

alias gcm='git commit -m'
alias gca='git commit --amend'

alias gp='git pull'
alias gup='git push'
alias gup-set='git push -u origin HEAD'
alias gpf='git push --force-with-lease' # Safer than --force

alias gd='git diff'
alias gds='git diff --staged'

alias gco='git checkout'
alias gcb='git checkout -b'
alias gom='git checkout main'

alias glog='git log --graph --pretty=format:"%C(auto)%h%C(reset) -%C(auto)%d%C(reset) %s %C(dim green)(%ar) %C(bold blue)<%an>%C(reset)"'