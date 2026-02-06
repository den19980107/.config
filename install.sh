#!/bin/bash

# =============================================================================
# .config Installation Script
# =============================================================================
# This script installs all necessary dependencies and plugins for the dotfiles
# in this .config repository. Run this script on a fresh macOS installation.
# =============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}\n"
}

print_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# =============================================================================
# HOMEBREW
# =============================================================================
print_header "Installing Homebrew"

if command_exists brew; then
    print_success "Homebrew already installed"
else
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    print_success "Homebrew installed"
fi

# Update Homebrew
brew update

# =============================================================================
# CORE CLI TOOLS
# =============================================================================
print_header "Installing Core CLI Tools"

# Essential tools
CORE_TOOLS=(
    git
    curl
    wget
    jq           # JSON processor (used by sketchybar/yabai scripts)
    make         # For building sketchybar helper
)

for tool in "${CORE_TOOLS[@]}"; do
    if command_exists "$tool"; then
        print_success "$tool already installed"
    else
        echo "Installing $tool..."
        brew install "$tool"
        print_success "$tool installed"
    fi
done

# =============================================================================
# SHELL - FISH
# =============================================================================
print_header "Installing Fish Shell"

if command_exists fish; then
    print_success "Fish shell already installed"
else
    brew install fish
    print_success "Fish shell installed"
fi

# Add fish to allowed shells and set as default
if ! grep -q "/opt/homebrew/bin/fish" /etc/shells; then
    echo "Adding fish to allowed shells..."
    echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
fi

# Set fish as default shell
if [[ "$SHELL" != *"fish"* ]]; then
    echo "Setting fish as default shell..."
    chsh -s /opt/homebrew/bin/fish
    print_success "Fish set as default shell"
fi

# =============================================================================
# OH MY FISH
# =============================================================================
print_header "Installing Oh My Fish"

if [[ -d "$HOME/.local/share/omf" ]]; then
    print_success "Oh My Fish already installed"
else
    echo "Installing Oh My Fish..."
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
    print_success "Oh My Fish installed"
fi

# =============================================================================
# PURE THEME FOR FISH (included in repo)
# =============================================================================
print_header "Fish Pure Theme"

if [[ -d "$HOME/.config/fish/functions/theme-pure" ]]; then
    print_success "Pure theme already present in config"
else
    print_warning "Pure theme not found. Clone it manually:"
    echo "  git clone https://github.com/pure-fish/pure ~/.config/fish/functions/theme-pure"
fi

# =============================================================================
# STARSHIP PROMPT
# =============================================================================
print_header "Installing Starship Prompt"

if command_exists starship; then
    print_success "Starship already installed"
else
    brew install starship
    print_success "Starship installed"
fi

# =============================================================================
# TERMINAL - KITTY
# =============================================================================
print_header "Installing Kitty Terminal"

if command_exists kitty; then
    print_success "Kitty already installed"
else
    brew install --cask kitty
    print_success "Kitty installed"
fi

# =============================================================================
# FONTS
# =============================================================================
print_header "Installing Fonts"

# Hack Nerd Font (used by kitty and sketchybar)
# Note: homebrew/cask-fonts tap is deprecated, fonts are now in main cask repo
if brew list --cask font-hack-nerd-font &>/dev/null; then
    print_success "Hack Nerd Font already installed"
else
    brew install --cask font-hack-nerd-font
    print_success "Hack Nerd Font installed"
fi

# =============================================================================
# NEOVIM
# =============================================================================
print_header "Installing Neovim"

if command_exists nvim; then
    print_success "Neovim already installed"
else
    brew install neovim
    print_success "Neovim installed"
fi

# Neovim dependencies
echo "Installing Neovim dependencies..."
NVIM_DEPS=(
    ripgrep      # Required by Telescope
    fd           # Required by Telescope
    lazygit      # Git UI
    node         # Required for LSP servers
    python3      # Python support
    luarocks     # Lua package manager
    cmake        # Required for telescope-fzf-native build
)

for dep in "${NVIM_DEPS[@]}"; do
    if command_exists "$dep" || brew list "$dep" &>/dev/null; then
        print_success "$dep already installed"
    else
        brew install "$dep"
        print_success "$dep installed"
    fi
done

# Install pynvim for Python support
pip3 install --user pynvim 2>/dev/null || print_warning "pynvim installation skipped"

# =============================================================================
# GO (Required for vim-go plugin)
# =============================================================================
print_header "Installing Go (for vim-go plugin)"

if command_exists go; then
    print_success "Go already installed"
else
    brew install go
    print_success "Go installed"
fi

# Install Go tools for vim-go
echo "Installing Go tools for vim-go..."
GO_TOOLS=(
    "golang.org/x/tools/gopls@latest"           # LSP server
    "github.com/go-delve/delve/cmd/dlv@latest"  # Debugger
    "golang.org/x/tools/cmd/goimports@latest"   # Imports formatter
    "mvdan.cc/gofumpt@latest"                   # Stricter formatter
    "github.com/fatih/gomodifytags@latest"      # Struct tag modifier
    "github.com/josharian/impl@latest"          # Interface implementation
    "github.com/cweill/gotests/gotests@latest"  # Test generator
)

for tool in "${GO_TOOLS[@]}"; do
    echo "  Installing $tool..."
    go install "$tool" 2>/dev/null || print_warning "Failed to install $tool"
done
print_success "Go tools installed"

# =============================================================================
# OPENCODE (Required for ThePrimeagen's 99 plugin)
# =============================================================================
print_header "Installing opencode (AI coding tool)"

echo "opencode is required for the '99' Neovim plugin (ThePrimeagen's AI agent)."
echo "Install via: go install github.com/opencode-ai/opencode@latest"
echo ""

if command_exists opencode; then
    print_success "opencode already installed"
else
    read -p "Install opencode? (y/N): " install_opencode
    if [[ "$install_opencode" =~ ^[Yy]$ ]]; then
        go install github.com/opencode-ai/opencode@latest 2>/dev/null && \
            print_success "opencode installed" || \
            print_warning "opencode installation failed. Install manually."
    fi
fi

# Note: Neovim plugins (AstroNvim) will be auto-installed on first launch

# =============================================================================
# TMUX
# =============================================================================
print_header "Installing Tmux"

if command_exists tmux; then
    print_success "Tmux already installed"
else
    brew install tmux
    print_success "Tmux installed"
fi

# Install TPM (Tmux Plugin Manager)
if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
    print_success "TPM already installed"
else
    echo "Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    print_success "TPM installed"
    print_warning "Run 'prefix + I' in tmux to install plugins"
fi

# =============================================================================
# WINDOW MANAGEMENT - AEROSPACE (recommended, replaces yabai/skhd)
# =============================================================================
print_header "Installing AeroSpace (Window Manager)"

if command_exists aerospace; then
    print_success "AeroSpace already installed"
else
    brew install --cask nikitabobko/tap/aerospace
    print_success "AeroSpace installed"
fi

# =============================================================================
# WINDOW MANAGEMENT - YABAI & SKHD (Legacy - optional)
# =============================================================================
print_header "Installing Yabai & SKHD (Legacy Window Management)"

echo "Note: AeroSpace is the primary window manager in this config."
echo "Yabai/SKHD are legacy configs. Install if needed."

read -p "Install Yabai & SKHD? (y/N): " install_yabai
if [[ "$install_yabai" =~ ^[Yy]$ ]]; then
    if command_exists yabai; then
        print_success "Yabai already installed"
    else
        brew install koekeishiya/formulae/yabai
        print_success "Yabai installed"
    fi

    if command_exists skhd; then
        print_success "SKHD already installed"
    else
        brew install koekeishiya/formulae/skhd
        print_success "SKHD installed"
    fi

    print_warning "Yabai requires SIP to be partially disabled for full functionality"
    print_warning "See: https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection"
fi

# =============================================================================
# SKETCHYBAR (Status Bar)
# =============================================================================
print_header "Installing Sketchybar"

read -p "Install Sketchybar status bar? (y/N): " install_sketchybar
if [[ "$install_sketchybar" =~ ^[Yy]$ ]]; then
    if command_exists sketchybar; then
        print_success "Sketchybar already installed"
    else
        brew tap FelixKratz/formulae
        brew install sketchybar
        print_success "Sketchybar installed"
    fi

    # Build the helper (required by sketchybar config)
    if [[ -d "$HOME/.config/sketchybar/helper" ]]; then
        echo "Building sketchybar helper..."
        cd "$HOME/.config/sketchybar/helper" && make
        print_success "Sketchybar helper built"
    fi
fi

# =============================================================================
# DEVELOPMENT TOOLS
# =============================================================================
print_header "Installing Development Tools"

# GitHub CLI
if command_exists gh; then
    print_success "GitHub CLI already installed"
else
    brew install gh
    print_success "GitHub CLI installed"
fi

# Kubectl (for Kubernetes)
if command_exists kubectl; then
    print_success "kubectl already installed"
else
    brew install kubectl
    print_success "kubectl installed"
fi

# Go environment manager (goenv)
if command_exists goenv; then
    print_success "goenv already installed"
else
    brew install goenv
    print_success "goenv installed"
fi

# =============================================================================
# OPTIONAL DEVELOPMENT TOOLS
# =============================================================================
print_header "Optional Development Tools"

OPTIONAL_TOOLS=(
    "go:Go programming language"
    "rust:Rust programming language"
    "docker:Docker containerization"
    "kubecolor:Colorized kubectl output"
)

for item in "${OPTIONAL_TOOLS[@]}"; do
    tool="${item%%:*}"
    description="${item#*:}"

    if command_exists "$tool" || brew list "$tool" &>/dev/null; then
        print_success "$tool already installed"
    else
        read -p "Install $tool ($description)? (y/N): " install_opt
        if [[ "$install_opt" =~ ^[Yy]$ ]]; then
            if [[ "$tool" == "docker" ]]; then
                brew install --cask docker
            else
                brew install "$tool"
            fi
            print_success "$tool installed"
        fi
    fi
done

# =============================================================================
# JAVA (for config.fish compatibility)
# =============================================================================
print_header "Java Configuration"

if /usr/libexec/java_home -v 1.8 &>/dev/null; then
    print_success "Java 8 found"
else
    print_warning "Java 8 not found. Install if needed:"
    echo "  brew install openjdk@8"
fi

# =============================================================================
# MACOS SETTINGS
# =============================================================================
print_header "macOS Settings"

echo "Configuring macOS settings for window management..."

# Disable window animations (helps with tiling WMs)
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Reduce transparency
defaults write com.apple.universalaccess reduceTransparency -bool true

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

print_success "macOS settings configured"

# =============================================================================
# POST-INSTALLATION NOTES
# =============================================================================
print_header "Post-Installation Notes"

echo -e "${GREEN}Installation complete!${NC}\n"

echo "Next steps:"
echo ""
echo "1. Restart your terminal or run: source ~/.config/fish/config.fish"
echo ""
echo "2. Launch Neovim to auto-install AstroNvim plugins:"
echo "   nvim"
echo "   Then run :Mason to install LSP servers"
echo ""
echo "3. Install tmux plugins (inside tmux):"
echo "   Press: prefix (Ctrl+a) + I"
echo ""
echo "4. Start AeroSpace window manager:"
echo "   Open AeroSpace from Applications (it will start at login)"
echo ""
echo "5. Configure GitHub CLI:"
echo "   gh auth login"
echo ""
echo "6. Install Go via goenv (for vim-go):"
echo "   goenv install <version> && goenv global <version>"
echo ""
echo "7. If using yabai, configure scripting addition:"
echo "   sudo yabai --load-sa"
echo ""

if [[ -d "$HOME/.config/fish/functions/theme-pure" ]]; then
    echo "8. Pure theme is configured in fish"
else
    echo "8. Clone Pure theme for fish:"
    echo "   git clone https://github.com/pure-fish/pure ~/.config/fish/functions/theme-pure"
fi

echo ""
echo "9. Configure opencode (if using 99 plugin):"
echo "   Set OPENCODE_API_KEY environment variable"

echo ""
echo -e "${YELLOW}Applications that may need manual installation:${NC}"
echo "  - Arc Browser"
echo "  - Visual Studio Code"
echo "  - Spotify"
echo "  - Microsoft Teams"
echo "  - LINE"
echo "  - WeChat"
echo "  - Notion"
echo "  - MongoDB Compass"
echo "  - Redis Insight"
echo "  - TablePlus"
echo "  - Sourcetree"
echo "  - Postman"
echo ""
echo -e "${BLUE}Enjoy your new setup!${NC}"
