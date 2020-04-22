# Environment variables
source ~/.zsh/zshenv.env

# Pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Aliases
source ~/.zsh/.aliases

# Functions
source ~/.zsh/.functions

# Color style
source ~/.zsh/style.zsh
