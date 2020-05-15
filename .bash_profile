# Language `en` and encoding `UTF-8`
export LANG=en_IE.UTF-8
export LC_ALL=en_IE.UTF-8

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Add julia to the `$PATH`
export PATH="/Applications/Julia-1.4.app/Contents/Resources/julia/bin:$PATH"

# Pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Docker
export DOCKER_VOLUME=~/docker/volume
export DOCKER_LOG=~/docker/log
