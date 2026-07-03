# Project Instructions

Instructions for Claude Code sessions working in this repository. This file
is loaded automatically into every session. Keep it short and current — it
is injected into every context window, so treat it like code and prune what
goes stale.

## About this repo

This repository is a **reference set** demonstrating the four mechanisms for
steering Claude Code. Each has a working example under `.claude/`:

| Mechanism | Example | Enforcement | Loaded |
|-----------|---------|-------------|--------|
| Memory    | this `CLAUDE.md`                        | soft (Claude follows) | always |
| Skill     | `.claude/skills/changelog-entry/`       | soft (on trigger)     | on trigger |
| Hook      | `.claude/settings.json` + `.claude/hooks/` | hard (harness runs) | on lifecycle event |
| Subagent  | `.claude/agents/code-reviewer.md`       | delegated             | on demand |

## Conventions

- Keep examples minimal and well-commented — they exist to be read and learned from.
- Test any script before committing it (e.g. run the hook with sample stdin).
- Prefer POSIX-friendly shell; degrade gracefully when a tool like `jq` is absent.

## Git

- Develop on the designated feature branch; do not commit directly to the default branch.
- Write descriptive commit messages explaining the "why", not just the "what".

## Never

- Never edit `.env` files, lockfiles, or anything under `secrets/`
  (the `protect-paths.sh` hook enforces this).
- Never commit the runtime `.claude/hook.log` (it is gitignored).
