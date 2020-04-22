# Environment variables
source ~/.zsh/zshenv.zsh

# Pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Aliases
source ~/.zsh/aliases.zsh

# Functions
source ~/.zsh/functions.zsh

# Color style
source ~/.zsh/style.zsh
