# Bootstrap macOS (Apple Silicon)

[![CI](https://github.com/munterfi/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/munterfi/dotfiles/actions/workflows/ci.yml)

This repository contains a reproducible setup for configuring a macOS development environment on a Apple Silicon
machine. It includes a Homebrew `Brewfile` and an idempotent `bootstrap.sh` script that can be safely re-run at any
time.

The setup is automated to install tools, configure the shell, and link custom configuration files (`.zsh`, `bin`, etc.)
from this repository.

## Features

- **Automated Setup**: A single script handles the entire installation.
- **Package Management**: Installs and updates all CLI tools and GUI applications from the `Brewfile`.
- **Shell Configuration**: Configures Zsh with modern tools like Starship, Zoxide, FZF, syntax highlighting, and
  autosuggestions.
- **Language Toolchains**:
    - Configures multiple Java versions (via `jenv`).
    - Installs Node LTS (via `fnm`).
    - Sets up the Rust toolchain (via `rustup`).
    - Sets up Python tooling (via `uv`).
- **Containerization**: Initializes Colima for a lightweight Docker experience optimized for Apple Silicon.
- **SSH & Git**: Generates a secure SSH key (ed25519) and configures it with the macOS Keychain if none exists.
- **Idempotent**: The script can be run multiple times without causing issues, as it only installs missing components.

## Usage

Clone the repository, enter its directory, and execute the bootstrap script.

```sh
git clone https://github.com/munterfi/dotfiles.git
cd dotfiles
./bootstrap.sh
```

A restart of the shell is required for all changes to be loaded correctly. The Docker environment can be started by
running the `colima start` command.

All CLI tools, languages, and GUI applications are declared in the `Brewfile`. The environment is customized by editing
this file to add or remove items. Re-running the bootstrap script will apply the changes.

## Local Overrides

Machine-specific aliases, exports, or settings that should not be committed can be placed in `.zsh/local.zsh`. This
file is listed in `.gitignore` and sourced automatically if it exists.

## Scripts

This repository contains several helper scripts located in the `bin` directory, which are automatically added to the
`$PATH`:

- `chk`: Verifies a file against a checksum, auto-detecting the algorithm (MD5, SHA1, SHA256).
- `codecat`: Prepares a project's source code for AI context by combining relevant files into a single, structured
  document.
- `git-id`: Switches the local Git `user.name` and `user.email` between "Personal" and "Work" profiles.
- `mkscr`: Interactively generates an executable script with a standardized header for various languages.

## Thanks To

This setup was inspired by the work and ideas from other developers and their dotfiles repositories:

- [mathiasbynens](https://github.com/mathiasbynens/dotfiles)
- [anishathalye](https://github.com/anishathalye/dotfiles)
- [jorisnoo](https://github.com/jorisnoo/dotfiles)
