#!/usr/bin/env bash
#
# Install/Update kitty-ai-subagent
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="${HOME}/.local/bin"

# If in a git repo, pull latest changes
if [[ -d "$SCRIPT_DIR/.git" ]]; then
    echo "Updating from git..."
    git -C "$SCRIPT_DIR" pull --ff-only || true
fi

echo "Installing kitty-ai-subagent..."

# Create install directory if needed
mkdir -p "$INSTALL_DIR"

# Copy script
cp "$SCRIPT_DIR/kitty-ai-subagent" "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/kitty-ai-subagent"

echo "Installed to: $INSTALL_DIR/kitty-ai-subagent"

# Check if in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "Note: $INSTALL_DIR is not in your PATH."
    echo "Add this to your ~/.zshrc or ~/.bashrc:"
    echo ""
    echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
fi

echo ""
echo "Done! Don't forget to configure Kitty:"
echo ""
echo "  # Add to ~/.config/kitty/kitty.conf"
echo "  allow_remote_control yes"
echo "  listen_on unix:/tmp/kitty-\$KITTY_PID"
