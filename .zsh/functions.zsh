# ==============================================================================
#  File System
# ==============================================================================

# Create a new directory and enter it
# Usage: mkd new_folder
# Usage: mkd path/to/new/folder
function mkd() {
    mkdir -p "$@" && cd "${@: -1}" || return
}

# Determine size of a file or total size of a directory
# Usage: fs           (Show size of all items in current dir)
# Usage: fs foldername (Show size of specific folder)
function fs() {
    if (( $# > 0 )); then
        du -sh "$@"
    else
        # macOS compatible 'du', sorted by size
        # 2>/dev/null suppresses errors if no dotfiles exist
        du -sh .[^.]* ./* 2>/dev/null | sort -h
    fi
}

# ==============================================================================
#  Archives
# ==============================================================================

# Create a .tar.gz archive, using `tar` built-in compression
# Usage: targz foldername      (Creates foldername.tar.gz)
# Usage: targz file1 file2     (Creates file1.tar.gz containing both files)
function targz() {
    # Use the first argument ($1) to name the archive, stripping trailing slashes
    local tmpFile="${1%/}.tar.gz"

    echo "Compressing to ${tmpFile}..."
    # -c: create, -z: gzip, -f: file
    tar --exclude=".DS_Store" -czf "${tmpFile}" "$@" || return 1

    echo "Success: ${tmpFile} created."
}

# Extract most known archives with one command
# Usage: extract archive.zip
# Usage: extract package.tar.gz
function extract() {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar e "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# ==============================================================================
#  Developer Tools
# ==============================================================================

# Interactive Process Killer (Requires fzf)
# Usage: fkill
# Usage: fkill 9 (Kill with SIGKILL instead of SIGTERM)
function fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ -n "$pid" ]; then
        echo "$pid" | xargs kill -"${1:-9}"
    fi
}