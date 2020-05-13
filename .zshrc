# Environment variables
source ~/.zsh/zshenv.zsh

# Autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# Syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Aliases
source ~/.zsh/aliases.zsh

# Functions
source ~/.zsh/functions.zsh

# Color style
#source ~/.zsh/style.zsh

# Starship
eval "$(starship init zsh)"

# Workaround Hyper first line precent sign (wait for v3.1.0)
unsetopt PROMPT_SP
