#!/bin/bash
# 🌋 Magmasnap Installer
# One-liner: curl -fsSL https://raw.githubusercontent.com/maximedelvaux/magmasnap/main/install.sh | bash

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

echo -e "${MAGENTA}"
cat << 'EOF'
   🌋 MAGMASNAP
   Ultra-minimal snapshot backups
EOF
echo -e "${NC}"

# Check for rsync
if ! command -v rsync &> /dev/null; then
    echo -e "${RED}❌ rsync is not installed${NC}"
    echo ""
    echo "Install it first:"
    echo "  • Ubuntu/Debian: sudo apt-get install rsync"
    echo "  • macOS: brew install rsync (or use built-in)"
    echo "  • Fedora/RHEL: sudo dnf install rsync"
    exit 1
fi

# Detect install location
if [ -w "/usr/local/bin" ]; then
    INSTALL_DIR="/usr/local/bin"
    NEEDS_SUDO=false
elif [ -d "$HOME/bin" ]; then
    INSTALL_DIR="$HOME/bin"
    NEEDS_SUDO=false
else
    # Create ~/bin if it doesn't exist
    INSTALL_DIR="$HOME/bin"
    mkdir -p "$INSTALL_DIR"
    NEEDS_SUDO=false
fi

echo -e "${BLUE}📦 Installing magmasnap...${NC}"
echo ""

# Download or copy the magmasnap script
SCRIPT_URL="https://raw.githubusercontent.com/maximedelvaux/magmasnap/main/magmasnap"
SCRIPT_PATH="$INSTALL_DIR/magmasnap"
ALIAS_PATH="$INSTALL_DIR/mgms"

# Check if we're running from the repo directory
if [ -f "$(dirname "$0")/magmasnap" ]; then
    echo -e "  Installing from local file..."
    cp "$(dirname "$0")/magmasnap" "$SCRIPT_PATH"
else
    echo -e "  Downloading latest version..."
    if command -v curl &> /dev/null; then
        curl -fsSL "$SCRIPT_URL" -o "$SCRIPT_PATH"
    elif command -v wget &> /dev/null; then
        wget -q "$SCRIPT_URL" -O "$SCRIPT_PATH"
    else
        echo -e "${RED}❌ Neither curl nor wget found${NC}"
        echo "Please install curl or wget first"
        exit 1
    fi
fi

chmod +x "$SCRIPT_PATH"

# Create mgms alias/symlink
ln -sf "$SCRIPT_PATH" "$ALIAS_PATH"

echo -e "${GREEN}✓ Installed successfully!${NC}"
echo ""
echo -e "${BLUE}Location:${NC} $SCRIPT_PATH"
echo -e "${BLUE}Shortcut:${NC} mgms (symlink created)"
echo -e "${BLUE}Backup directory:${NC} ~/.magmasnap (configurable)"
echo ""

# Check if install directory is in PATH
if echo "$PATH" | grep -q "$INSTALL_DIR"; then
    echo -e "${GREEN}✓ Ready to use!${NC}"
    echo ""
    echo "Try it now:"
    echo -e "  ${YELLOW}mgms save${NC}       (or: magmasnap save)"
    echo -e "  ${YELLOW}mgms list${NC}       (or: magmasnap list)"
else
    echo -e "${YELLOW}⚠️  Adding $INSTALL_DIR to your PATH...${NC}"

    # Detect shell
    if [ -n "$BASH_VERSION" ]; then
        SHELL_RC="$HOME/.bashrc"
    elif [ -n "$ZSH_VERSION" ]; then
        SHELL_RC="$HOME/.zshrc"
    else
        SHELL_RC="$HOME/.profile"
    fi

    # Add to PATH if not already there
    if ! grep -q "export PATH=\"\$HOME/bin:\$PATH\"" "$SHELL_RC" 2>/dev/null; then
        echo "" >> "$SHELL_RC"
        echo '# Added by magmasnap installer' >> "$SHELL_RC"
        echo 'export PATH="$HOME/bin:$PATH"' >> "$SHELL_RC"
        echo -e "${GREEN}✓ Added to $SHELL_RC${NC}"
    fi

    echo ""
    echo "Activate now:"
    echo -e "  ${YELLOW}source $SHELL_RC${NC}"
    echo ""
    echo "Or open a new terminal, then try:"
    echo -e "  ${YELLOW}mgms save${NC}"
fi

echo ""
echo -e "${BLUE}📖 Quick Reference:${NC}"
echo "  mgms save [tag]    Create snapshot"
echo "  mgms list          View snapshots"
echo "  mgms restore N     Restore snapshot N"
echo "  mgms diff N        See changes"
echo "  mgms rm N          Remove snapshot N"
echo "  mgms clean         Remove all (current project)"
echo "  mgms clear         Remove all (all projects)"
echo "  mgms auto [MIN]    Auto-snapshot every N minutes"
echo ""
echo -e "${MAGENTA}🌋 Happy snapshotting!${NC}"
