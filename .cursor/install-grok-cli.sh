#!/bin/bash
# Install Grok / xAI CLI if not already installed
# Run this script if grok is not available in your cloud agent

set -e

echo "Checking for Grok CLI installation..."

export PATH="$HOME/.grok/bin:$PATH"

if command -v grok &> /dev/null; then
    echo "Grok CLI is already installed: $(grok --version 2>/dev/null || echo present)"
    exit 0
fi

echo "Installing Grok CLI..."
curl -fsSL https://x.ai/cli/install.sh | bash

# Ensure ~/.grok/bin is on PATH for future bash sessions
if [ -f "$HOME/.bashrc" ] && ! grep -q 'export PATH="$HOME/.grok/bin:$PATH"' "$HOME/.bashrc"; then
    # Official installer usually adds a grok installer block; add a fallback if missing
    if ! grep -qs "grok installer" "$HOME/.bashrc" 2>/dev/null; then
        echo 'export PATH="$HOME/.grok/bin:$PATH"' >> "$HOME/.bashrc"
        echo "Added ~/.grok/bin to PATH in .bashrc"
    fi
fi

export PATH="$HOME/.grok/bin:$PATH"

echo "Grok CLI installed: $(grok --version 2>/dev/null || echo present at $HOME/.grok/bin/grok)"
echo ""
echo "Auth: set GROK_DEPLOYMENT_KEY in Cursor Cloud Agents Secrets, or run: grok login"
echo "Docs: .cursor/README-GROK-CLI.md"
