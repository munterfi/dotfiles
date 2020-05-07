# Color CLI
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Show git branch and color prompt
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}
setopt PROMPT_SUBST
export PROMPT='%F{yellow}%n%f %F{cyan}%~%f %F{green}$(parse_git_branch)%f %F{normal}$%f '
