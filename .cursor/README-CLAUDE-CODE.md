# Claude Code in Cloud Agents

This directory contains scripts for setting up Claude Code CLI in Cursor Cloud Agents.

## Quick Start

### 1. Install Claude Code

```bash
./.cursor/install-claude-code.sh
```

This installs Claude Code v2.1.207+ and adds it to your PATH.

### 2. Set Up Persistent Memory (Optional)

```bash
./.cursor/setup-claude-mem.sh
```

Follow the instructions to install the `claude-mem` plugin, which provides:
- Persistent memory across sessions
- Automatic context compression
- Semantic search of project history
- ~10x token savings

### 3. Authenticate

You need either:

**Option A: Anthropic API Key** (Recommended for cloud agents)
- Add `ANTHROPIC_API_KEY` to Cursor Dashboard → Cloud Agents → Secrets
- Use `claude --bare` mode or set as environment variable

**Option B: Claude Subscription**
- Run `claude auth login` (requires Pro/Max/Team/Enterprise)
- May be challenging in cloud environment due to browser-based OAuth

## Making It Permanent

For persistent setup across all cloud agents, run an environment setup agent at:
**[cursor.com/onboard](https://cursor.com/onboard)**

Suggested prompt:
> "Install Claude Code CLI (v2.1.207+) using the native installer (curl -fsSL https://claude.ai/install.sh | bash) and ensure ~/.local/bin is in PATH. This should be available for all cloud agents working on this repository."

## Usage

```bash
# Start interactive session
claude

# Check installation
claude --version
claude doctor

# Use with API key (bare mode)
claude --bare

# Background agent mode
claude --background

# Help
claude --help
```

## Memory Systems

### Built-in Automemory
Claude Code v2.1.59+ includes lightweight auto-memory that:
- Keeps recent interactions in context
- Summarizes older content
- Prioritizes instructions and decisions

### claude-mem Plugin
Third-party plugin that provides:
- Full persistent memory across sessions
- Vector search via ChromaDB
- SQLite database for observations
- Web UI at http://localhost:37777
- MCP tools: `search`, `timeline`, `get_observations`

## Resources

- [Claude Code Docs](https://code.claude.com/docs/en/)
- [claude-mem GitHub](https://github.com/thedotmack/claude-mem)
- [claude-mem Documentation](https://thedotmack-claude-mem.mintlify.app/)
