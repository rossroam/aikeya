#!/bin/bash
# Install Claude Code CLI if not already installed
# Run this script if Claude Code is not available in your cloud agent

set -e

echo "Checking for Claude Code installation..."

if command -v claude &> /dev/null; then
    echo "✅ Claude Code is already installed: $(claude --version)"
    exit 0
fi

echo "Installing Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash

# Add to PATH if not already there
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    echo "✅ Added ~/.local/bin to PATH in .bashrc"
fi

# Load PATH for current session
export PATH="$HOME/.local/bin:$PATH"

echo "✅ Claude Code installed: $(claude --version)"
echo ""
echo "Note: For persistent installation across all cloud agents, run an env setup agent at:"
echo "https://cursor.com/onboard"
