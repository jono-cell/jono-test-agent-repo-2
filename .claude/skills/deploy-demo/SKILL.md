---
name: deploy-demo
description: >-
  Demo skill showing how a skill takes arguments. Deploys the app to a
  named environment. Use when the user types /deploy-demo or asks to deploy.
argument-hint: "[environment] [--migrate]"
arguments: [environment, migrate_flag]
disable-model-invocation: true
allowed-tools:
  - AskUserQuestion
---

# Deploy Demo

This skill demonstrates the two ways a skill collects input:
the fast **typed-argument** path and the guided **AskUserQuestion** fallback.

## 1. Resolve the target environment

- If `$environment` is provided (the first argument), use it directly.
  Example: `/deploy-demo production` → deploy to `production`.
- If `$environment` is EMPTY (the user just typed `/deploy-demo`), ask them
  with `AskUserQuestion`:
    - question: "Which environment should I deploy to?"
    - header: "Environment"
    - options: "staging", "production", "canary"
  Use their selection as the environment.

## 2. Resolve whether to run migrations

- If the second argument `$migrate_flag` is `--migrate`, run migrations.
- Otherwise, ask with `AskUserQuestion`:
    - question: "Run database migrations before deploying?"
    - header: "Migrations"
    - options: "Yes, migrate first", "No, skip migrations"

## 3. Show the plan (this demo stops here — it does not really deploy)

Print a summary the user can confirm, e.g.:

> Would deploy to **<environment>**, migrations: **<yes/no>**.

Do NOT run any real deploy commands — this skill exists to demonstrate
argument handling, not to ship anything.
