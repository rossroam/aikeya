# AGENTS.md

## Cursor Cloud specific instructions

Aikeya is a **single SvelteKit + Tauri app** (web is the primary target; the Tauri desktop shell is an optional macOS beta). It is **local-first**: all user data lives in the browser (IndexedDB via Dexie), there is **no server-side database** despite the `DATABASE_URL` entry in `.env.example` (it is vestigial and not wired up — ignore it; no Docker/Postgres is needed).

Standard commands live in `package.json` scripts and `CONTRIBUTING.md`. Key ones: `pnpm dev` (web app at http://localhost:5173), `pnpm lint` / `pnpm check` (svelte-check), `pnpm build`. `pnpm test` is a no-op (no test suite configured).

Non-obvious notes:
- Node >=22 and pnpm are required (`.npmrc` sets `engine-strict=true`). The update script runs `pnpm install`.
- `pnpm install` prints a warning about ignored build scripts (esbuild, protobufjs, sharp). This is harmless — dev, lint, and build all work without approving them. Do NOT run the interactive `pnpm approve-builds`.
- `pnpm build` runs a `postbuild` Pagefind indexing step that logs "Pagefind was not able to build an index" and exits 0 via an `|| echo` fallback. This is expected in a fresh checkout and does not indicate a build failure.
- `pnpm tauri dev` additionally needs the Rust toolchain (already present as `cargo`) and is only meaningful on a desktop/GUI target; the web flow via `pnpm dev` is sufficient for most testing.

Testing the core chat feature (end-to-end) requires an LLM provider. Chat is configured at runtime in the app (onboarding "Configure AI Services" step, or Settings), not via env vars/secrets. Options:
- **Cloud provider** (OpenAI/Anthropic/Google/DeepSeek/xAI): user pastes an API key in the UI.
- **Local, no API key — used for cloud-agent testing:** run **Ollama** on port 11434 and select provider "Ollama" with a pulled model (e.g. `llama3.2:1b`), leaving the base URL default `http://localhost:11434/v1/`. The app proxies chat through its `/api/chat` route to that base URL.
  - Ollama is NOT a project dependency and is not installed by the update script. If you need local chat, install it yourself (`curl -fsSL https://ollama.com/install.sh | sh`; needs the `zstd` apt package).
  - **Gotcha:** the latest Ollama (0.31.x from the install script) segfaults (`llama-server ... signal: segmentation fault`) on this VM for every model. Pin a known-good older release instead: `OLLAMA_VERSION=0.6.8 sh install.sh`. Start it with `ollama serve` (systemd is not running in the VM, so start it manually), then `ollama pull llama3.2:1b`.
