# Language `en` and encoding `UTF-8`
export LANG=en_IE.UTF-8
export LC_ALL=en_IE.UTF-8

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Add java openjdk to the `$PATH` 
# sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# Add julia to the `$PATH`
export PATH="/Applications/Julia-1.5.app/Contents/Resources/julia/bin:$PATH"

# Add vscode to the `$PATH`
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin" 

# Docker
export DOCKER_VOLUME=~/docker/volume
export DOCKER_LOG=~/docker/log
