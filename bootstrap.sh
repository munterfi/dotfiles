#!/usr/bin/env bash
#===============================================================================
# macOS Bootstrap
#
# Description: Idempotent developer setup of macOS on Silicon chip.
#              Installs tools, configures shell, and links custom dotfiles.
# Usage: ./bootstrap.sh
#===============================================================================

set -Eeuo pipefail

# Get the directory where this script is located (for symlinking)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Styling & Logging ---
BLUE="$(tput setaf 4)"; GREEN="$(tput setaf 2)"; RESET="$(tput sgr0)"
info()    { echo -e "${BLUE}ℹ${RESET} $*"; }
success() { echo -e "${GREEN}✔${RESET} $*"; }

# --- Helper: Idempotent Configuration ---

# Appends a line to a file only if it doesn't already exist.
ensure_line() {
    local line="$1"
    local file="$2"
    mkdir -p "$(dirname "$file")"
    touch "$file"
    if ! grep -qF "$line" "$file"; then
        echo "$line" >> "$file"
    fi
}

# Links a file/folder from the repo to HOME, replacing if necessary
ensure_symlink() {
    local source_path="$DOTFILES_DIR/$1"
    local dest_path="$HOME/$1"

    if [ ! -e "$source_path" ]; then
        info "Skipping link: $source_path not found in repo."
        return
    fi

    # Check if link already exists and points to the right place
    if [ -L "$dest_path" ] && [ "$(readlink "$dest_path")" = "$source_path" ]; then
        # Already linked correctly
        return
    fi

    # Backup existing file/dir if it isn't a symlink
    if [ -e "$dest_path" ] && [ ! -L "$dest_path" ]; then
        info "Backing up existing $dest_path to $dest_path.bak"
        mv "$dest_path" "$dest_path.bak"
    fi

    # Force create/replace symlink
    # -s: symbolic, -n: treat dest as normal file if it's a dir, -f: force
    ln -snf "$source_path" "$dest_path"
    success "Linked ~/$1"
}

#===============================================================================
# 1. System Essentials
#===============================================================================

install_xcode() {
    if ! xcode-select -p &>/dev/null; then
        info "Installing Xcode Command Line Tools..."
        xcode-select --install
        # Note: This requires user interaction via a popup
        exit 0
    else
        success "Xcode CLI installed"
    fi
}

install_homebrew() {
    # 1. Install if missing
    if [ ! -f "/opt/homebrew/bin/brew" ]; then
        info "Installing Homebrew..."
        export HOMEBREW_NO_ANALYTICS=1
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # 2. Configure Persistence (.zprofile)
    ensure_line 'eval "$(/opt/homebrew/bin/brew shellenv)"' "$HOME/.zprofile"

    # 3. Load into Current Session
    eval "$(/opt/homebrew/bin/brew shellenv)"

    success "Homebrew installed & configured"
}

install_deps() {
    info "Syncing dependencies from Brewfile..."

    if [ ! -f "Brewfile" ]; then
        echo "Error: Brewfile not found in current directory."
        exit 1
    fi

    # --cleanup: Uninstall packages NOT in the Brewfile
    brew bundle --cleanup

    success "Dependencies synced"
}

#===============================================================================
# 2. Symlinks (Custom Configs)
#===============================================================================
setup_symlinks() {
    info "Linking custom configurations..."

    # Links the 'bin' folder from your repo to ~/bin
    ensure_symlink "bin"

    # Links the '.zsh' folder (containing aliases.zsh/functions.zsh) to ~/.zsh
    ensure_symlink ".zsh"
}

#===============================================================================
# 3. SSH Identity
#===============================================================================
setup_ssh() {
    local ssh_key="$HOME/.ssh/id_ed25519"
    local ssh_config="$HOME/.ssh/config"

    # 1. Generate Key
    if [ ! -f "$ssh_key" ]; then
        local label
        label="$(whoami)@$(hostname -s)"
        info "Generating SSH key ($label)..."
        ssh-keygen -t ed25519 -C "$label" -f "$ssh_key"
        eval "$(ssh-agent -s)"
        ssh-add --apple-use-keychain "$ssh_key"
        success "SSH Key created"
    fi

    # 2. Configure SSH to use Keychain
    if [ ! -f "$ssh_config" ]; then
        touch "$ssh_config"
    fi

    if ! grep -q "UseKeychain yes" "$ssh_config"; then
        info "Configuring SSH config..."
        {
            echo ""
            echo "Host *"
            echo "  AddKeysToAgent yes"
            echo "  UseKeychain yes"
            echo "  IdentityFile ~/.ssh/id_ed25519"
        } >> "$ssh_config"
        success "SSH Config updated"
    fi
}

#===============================================================================
# 4. Docker (Colima)
#===============================================================================
setup_docker() {
    if [ ! -f "$HOME/.colima/default/colima.yaml" ]; then
        info "Initializing Colima config..."
        colima start --cpu 4 --memory 8 --vm-type=vz --vz-rosetta --mount-type=virtiofs
        colima stop
        success "Colima Configured"
    else
        success "Colima already configured"
    fi
}

#===============================================================================
# 5. Shell Configuration
#===============================================================================
setup_shell() {
    local zshrc="$HOME/.zshrc"
    local zshenv="$HOME/.zshenv"
    local brew_prefix
    brew_prefix="$(brew --prefix)"

    info "Configuring Zsh..."

    # --- .zshenv Setup ---
    # Add ~/bin to PATH (ensure_line handles idempotency)
    ensure_line 'export PATH="$HOME/bin:$PATH"' "$zshenv"

    # --- .zshrc Setup ---

    # 1. Custom Aliases & Functions (Your request)
    # We use quotes to prevent immediate variable expansion, ensure_line handles the rest
    ensure_line '# Aliases' "$zshrc"
    ensure_line 'source ~/.zsh/aliases.zsh' "$zshrc"
    ensure_line '# Functions' "$zshrc"
    ensure_line 'source ~/.zsh/functions.zsh' "$zshrc"
    ensure_line '[[ -f ~/.zsh/local.zsh ]] && source ~/.zsh/local.zsh' "$zshrc"

    # 2. Autocompletion
    ensure_line "FPATH=${brew_prefix}/share/zsh/site-functions:\${FPATH}" "$zshrc"
    ensure_line "autoload -Uz compinit && compinit" "$zshrc"

    # 3. Tool Initialization
    ensure_line 'eval "$(fnm env --use-on-cd)"' "$zshrc"
    ensure_line 'eval "$(jenv init -)"' "$zshrc"
    ensure_line 'eval "$(zoxide init zsh)"' "$zshrc"
    ensure_line 'eval "$(starship init zsh)"' "$zshrc"
    ensure_line 'eval "$(uv generate-shell-completion zsh)"' "$zshrc"

    # 4. FZF & Cargo
    ensure_line '[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"' "$zshrc"
    ensure_line 'source <(fzf --zsh)' "$zshrc"

    # 5. Plugins (Syntax Highlighting last)
    ensure_line "source ${brew_prefix}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" "$zshrc"
    ensure_line "source ${brew_prefix}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" "$zshrc"

    success "Shell Configured"
}

#===============================================================================
# 6. Language Toolchains
#===============================================================================
setup_langs() {
    # --- Rust ---
    if ! rustup toolchain list | grep -q "stable"; then
        info "Initializing Rust..."
        rustup default stable
    fi

    # --- Node ---
    eval "$(fnm env --use-on-cd)"
    if ! fnm list | grep -q "lts"; then
        fnm install --lts
        fnm default lts-latest
    fi

    # --- Java ---
    export PATH="$HOME/.jenv/bin:$PATH"
    export PROMPT_COMMAND="${PROMPT_COMMAND:-}"
    eval "$(jenv init -)"
    jenv enable-plugin export >/dev/null 2>&1 || true

    for jdk in /opt/homebrew/opt/openjdk*/libexec/openjdk.jdk/Contents/Home; do
        if [ -d "$jdk" ]; then
            jenv add "$jdk" >/dev/null 2>&1 || true
        fi
    done

    success "Languages Configured"
}

#===============================================================================
# MAIN
#===============================================================================
main() {
    install_xcode
    install_homebrew
    install_deps
    setup_symlinks # Links bin/ and .zsh/ from repo
    setup_ssh
    setup_docker
    setup_shell    # Adds source lines and PATH to zshrc/zshenv
    setup_langs

    success "Bootstrap Complete! Restart your terminal."
}

main
