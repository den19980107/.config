#!/usr/bin/env bash
#
# Setup script for .config dotfiles
# Installs all required dependencies for the Neovim configuration
#
# Usage: ./scripts/setup.sh
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() { echo -e "${BLUE}[*]${NC} $1"; }
print_success() { echo -e "${GREEN}[✓]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[!]${NC} $1"; }
print_error() { echo -e "${RED}[✗]${NC} $1"; }

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ -f /etc/debian_version ]]; then
        echo "debian"
    elif [[ -f /etc/fedora-release ]]; then
        echo "fedora"
    elif [[ -f /etc/arch-release ]]; then
        echo "arch"
    else
        echo "unknown"
    fi
}

OS=$(detect_os)
print_status "Detected OS: $OS"

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install package based on OS
install_package() {
    local package=$1
    local brew_package=${2:-$1}
    local apt_package=${3:-$1}
    
    if command_exists "$package"; then
        print_success "$package is already installed"
        return 0
    fi
    
    print_status "Installing $package..."
    
    case $OS in
        macos)
            if command_exists brew; then
                brew install "$brew_package"
            else
                print_error "Homebrew not found. Please install it first: https://brew.sh"
                return 1
            fi
            ;;
        debian)
            sudo apt-get update && sudo apt-get install -y "$apt_package"
            ;;
        fedora)
            sudo dnf install -y "$apt_package"
            ;;
        arch)
            sudo pacman -S --noconfirm "$apt_package"
            ;;
        *)
            print_warning "Unknown OS. Please install $package manually."
            return 1
            ;;
    esac
    
    print_success "$package installed"
}

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║           .config Dotfiles Setup Script                      ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# =============================================================================
# Core Dependencies
# =============================================================================

print_status "Checking core dependencies..."

# Git
if ! command_exists git; then
    install_package git
else
    print_success "git is already installed ($(git --version | cut -d' ' -f3))"
fi

# Neovim (>= 0.10 recommended for best compatibility)
if command_exists nvim; then
    NVIM_VERSION=$(nvim --version | head -1 | grep -oE 'v[0-9]+\.[0-9]+' | head -1)
    print_success "neovim is already installed ($NVIM_VERSION)"
    
    # Check version
    MAJOR=$(echo "$NVIM_VERSION" | sed 's/v//' | cut -d. -f1)
    MINOR=$(echo "$NVIM_VERSION" | sed 's/v//' | cut -d. -f2)
    if [[ $MAJOR -eq 0 && $MINOR -lt 10 ]]; then
        print_warning "Neovim $NVIM_VERSION detected. Recommend upgrading to 0.10+ for best compatibility."
    fi
else
    print_status "Installing neovim..."
    case $OS in
        macos)
            brew install neovim
            ;;
        debian)
            # Use the official Neovim PPA for latest version
            print_status "Adding Neovim PPA for latest version..."
            sudo apt-get install -y software-properties-common
            sudo add-apt-repository -y ppa:neovim-ppa/unstable
            sudo apt-get update
            sudo apt-get install -y neovim
            ;;
        *)
            install_package nvim neovim neovim
            ;;
    esac
fi

# =============================================================================
# 99 Plugin Dependencies (ThePrimeagen's AI Agent)
# =============================================================================

print_status "Checking 99 plugin dependencies..."

# OpenCode (required for 99 plugin)
if command_exists opencode; then
    print_success "opencode is already installed ($(opencode --version 2>&1 | tail -1))"
else
    print_status "Installing opencode (required for 99 AI plugin)..."
    
    # Detect architecture
    ARCH=$(uname -m)
    case $ARCH in
        x86_64) ARCH_NAME="x86_64" ;;
        aarch64|arm64) ARCH_NAME="arm64" ;;
        *) print_error "Unsupported architecture: $ARCH"; exit 1 ;;
    esac
    
    case $OS in
        macos)
            DOWNLOAD_URL=$(curl -sL https://api.github.com/repos/opencode-ai/opencode/releases/latest | grep "browser_download_url.*mac.*${ARCH_NAME}.*tar.gz" | head -1 | cut -d'"' -f4)
            ;;
        *)
            DOWNLOAD_URL=$(curl -sL https://api.github.com/repos/opencode-ai/opencode/releases/latest | grep "browser_download_url.*linux.*${ARCH_NAME}.*tar.gz" | head -1 | cut -d'"' -f4)
            ;;
    esac
    
    if [[ -n "$DOWNLOAD_URL" ]]; then
        TMP_DIR=$(mktemp -d)
        curl -sL "$DOWNLOAD_URL" -o "$TMP_DIR/opencode.tar.gz"
        tar -xzf "$TMP_DIR/opencode.tar.gz" -C "$TMP_DIR"
        
        # Install to /usr/local/bin or ~/.local/bin
        if [[ -w /usr/local/bin ]]; then
            mv "$TMP_DIR/opencode" /usr/local/bin/
        else
            mkdir -p ~/.local/bin
            mv "$TMP_DIR/opencode" ~/.local/bin/
            print_warning "Installed to ~/.local/bin - make sure it's in your PATH"
        fi
        
        rm -rf "$TMP_DIR"
        print_success "opencode installed"
    else
        print_error "Failed to find opencode download URL"
        print_warning "Please install manually: https://github.com/opencode-ai/opencode"
    fi
fi

# =============================================================================
# Recommended Tools (for enhanced experience)
# =============================================================================

print_status "Checking recommended tools..."

# ripgrep (faster file search)
if command_exists rg; then
    print_success "ripgrep is already installed"
else
    print_status "Installing ripgrep (recommended for better search)..."
    install_package rg ripgrep ripgrep
fi

# fd (faster file finder)
if command_exists fd; then
    print_success "fd is already installed"
else
    print_status "Installing fd (recommended for better file finding)..."
    case $OS in
        debian)
            install_package fd fd-find fd-find
            # Create symlink on Debian-based systems
            if ! command_exists fd && command_exists fdfind; then
                sudo ln -sf $(which fdfind) /usr/local/bin/fd 2>/dev/null || true
            fi
            ;;
        *)
            install_package fd fd fd
            ;;
    esac
fi

# fzf (fuzzy finder)
if command_exists fzf; then
    print_success "fzf is already installed"
else
    print_status "Installing fzf (recommended for fuzzy finding)..."
    install_package fzf fzf fzf
fi

# Node.js (for some LSP servers and plugins)
if command_exists node; then
    print_success "node is already installed ($(node --version))"
else
    print_status "Installing Node.js (needed for some LSP servers)..."
    case $OS in
        macos)
            brew install node
            ;;
        debian)
            # Install via NodeSource for latest LTS
            curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
            sudo apt-get install -y nodejs
            ;;
        *)
            install_package node nodejs nodejs
            ;;
    esac
fi

# =============================================================================
# Go (for vim-go plugin)
# =============================================================================

if command_exists go; then
    print_success "go is already installed ($(go version | cut -d' ' -f3))"
else
    print_warning "Go is not installed. vim-go plugin will have limited functionality."
    print_warning "Install Go from: https://go.dev/dl/"
fi

# =============================================================================
# Nerd Fonts (optional but recommended)
# =============================================================================

print_status "Checking for Nerd Fonts..."

check_nerd_fonts() {
    if command_exists fc-list; then
        if fc-list | grep -qi "nerd\|Hack\|JetBrains\|FiraCode"; then
            return 0
        fi
    fi
    return 1
}

if check_nerd_fonts; then
    print_success "Nerd Fonts detected"
else
    print_warning "No Nerd Fonts detected. Icons may not display correctly."
    print_warning "Recommended: Install a Nerd Font from https://www.nerdfonts.com/"
    print_warning "  e.g., JetBrainsMono Nerd Font, Hack Nerd Font, etc."
fi

# =============================================================================
# Setup Symlinks
# =============================================================================

echo ""
print_status "Setting up configuration symlinks..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$(dirname "$SCRIPT_DIR")"

# Create XDG config directory if it doesn't exist
mkdir -p ~/.config

# Symlink configurations
symlink_config() {
    local src="$CONFIG_DIR/$1"
    local dst="$HOME/.config/$1"
    
    if [[ -e "$src" ]]; then
        if [[ -L "$dst" ]]; then
            print_success "$1 symlink already exists"
        elif [[ -e "$dst" ]]; then
            print_warning "$dst already exists (not a symlink). Backing up..."
            mv "$dst" "$dst.backup.$(date +%Y%m%d%H%M%S)"
            ln -sf "$src" "$dst"
            print_success "$1 symlink created (old config backed up)"
        else
            ln -sf "$src" "$dst"
            print_success "$1 symlink created"
        fi
    fi
}

# Symlink main configs
symlink_config "nvim"
symlink_config "fish"
symlink_config "kitty"
symlink_config "tmux"

# =============================================================================
# Install Neovim Plugins
# =============================================================================

echo ""
print_status "Installing Neovim plugins (this may take a moment)..."

# Run Lazy sync in headless mode
nvim --headless "+Lazy! sync" +qa 2>/dev/null || true

print_success "Neovim plugins installed"

# =============================================================================
# Summary
# =============================================================================

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                    Setup Complete! 🎉                        ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
print_success "All dependencies installed!"
echo ""
echo "Next steps:"
echo "  1. Open Neovim: nvim"
echo "  2. For 99 AI plugin: Configure OpenCode (opencode config)"
echo "  3. Use <leader>9f to fill in functions with AI"
echo "  4. Use <leader>9v in visual mode for AI prompts"
echo ""
echo "For more info on the 99 plugin:"
echo "  https://github.com/ThePrimeagen/99"
echo ""
