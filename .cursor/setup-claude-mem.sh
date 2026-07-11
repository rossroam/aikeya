#!/bin/bash
# Install and configure claude-mem plugin for Claude Code
# This provides persistent memory across sessions

set -e

echo "Setting up claude-mem plugin for Claude Code..."

# Ensure Claude Code is installed
if ! command -v claude &> /dev/null; then
    echo "❌ Claude Code is not installed. Run ./install-claude-code.sh first."
    exit 1
fi

export PATH="$HOME/.local/bin:$PATH"

echo "Claude Code version: $(claude --version)"
echo ""
echo "To install claude-mem plugin, start a Claude Code session and run:"
echo ""
echo "  /plugin marketplace add thedotmack/claude-mem"
echo "  /plugin install claude-mem"
echo ""
echo "Then restart Claude Code."
echo ""
echo "What claude-mem does:"
echo "  - Captures all tool usage, file edits, and decisions"
echo "  - Compresses them into semantic summaries"
echo "  - Injects relevant context into future sessions"
echo "  - Provides MCP tools: search, timeline, get_observations"
echo "  - Saves ~10x tokens by using progressive disclosure"
echo ""
echo "View memory stream at: http://localhost:37777"
echo ""
echo "For API key setup, add ANTHROPIC_API_KEY to Cursor Dashboard:"
echo "https://cursor.com/settings (Cloud Agents > Secrets)"
