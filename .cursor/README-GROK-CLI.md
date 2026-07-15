# Grok CLI in Cloud Agents

Scripts and notes for installing the Grok / xAI CLI (`grok` / `agent`) in Cursor Cloud Agents.

## Make the repo private (required)

This repository should be **private**. Cloud agent tokens cannot change GitHub visibility; do it yourself:

1. Open [github.com/rossroam/aikeya/settings](https://github.com/rossroam/aikeya/settings)
2. **Danger Zone** → **Change repository visibility** → **Make private**
3. Confirm Cursor’s GitHub connection can still access the private repo

CLI install does not depend on privacy; keep the repo private before putting secrets or private work here.

## Quick Start

### 1. Install Grok CLI

```bash
./.cursor/install-grok-cli.sh
```

Or manually:

```bash
curl -fsSL https://x.ai/cli/install.sh | bash
```

The installer places binaries in `~/.grok/bin` (`grok` and `agent`) and updates your shell PATH.

### 2. Authenticate (Cursor Secrets)

Installer works without auth; **using** the CLI needs credentials.

**Recommended for cloud agents:** add a Runtime Secret in the Cursor dashboard:

1. Open [cursor.com/dashboard/cloud-agents](https://cursor.com/dashboard/cloud-agents) → **Secrets**
2. Add `GROK_DEPLOYMENT_KEY` as a **Runtime Secret** (redacted from transcripts)
3. Start a new cloud agent (or restart) so the secret is injected

**Fallback:** `grok login` (browser OAuth — awkward in cloud VMs). Prefer the deployment key.

Do **not** commit API keys or `~/.grok/auth.json`.

### 3. Verify

```bash
export PATH="$HOME/.grok/bin:$PATH"
grok --version
# or
agent --help
```

## Persistent install across agents

[`.cursor/environment.json`](./environment.json) runs this install on cloud agent boot:

```json
{
  "install": "pnpm install && bash .cursor/install-grok-cli.sh"
}
```

After the first successful update, Cursor may snapshot the VM so later agents start faster. The install script is idempotent.

You can also run an environment setup agent at [cursor.com/onboard](https://cursor.com/onboard) and save a snapshot.

## Usage

```bash
grok
agent
grok --version
grok --help
```

## Resources

- Installer: https://x.ai/cli/install.sh
- Cursor Cloud Agents secrets: https://cursor.com/dashboard/cloud-agents
- Cursor cloud setup docs: https://cursor.com/docs/cloud-agent/setup
