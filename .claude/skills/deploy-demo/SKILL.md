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

The valid environments are exactly: `staging`, `production`, `canary`.

## 1. Resolve the target environment

- If `$environment` is provided (the first argument), use it directly.
  Example: `/deploy-demo production` → deploy to `production`.
- If `$environment` is EMPTY (the user just typed `/deploy-demo`), ask them
  with `AskUserQuestion`:
    - question: "Which environment should I deploy to?"
    - header: "Environment"
    - options: "staging", "production", "canary"
- Restrict to the listed options. `AskUserQuestion` always shows an "Other"
  free-text choice that cannot be hidden — if the user answers with anything
  other than `staging`, `production`, or `canary`, reject it and ask the same
  question again until they pick a valid option.

## 2. Resolve whether to run migrations

- If the second argument `$migrate_flag` is `--migrate`, run migrations.
- Otherwise, ask with `AskUserQuestion`:
    - question: "Run database migrations before deploying?"
    - header: "Migrations"
    - options: "Yes, migrate first", "No, skip migrations"
- Same rule: if the answer is not one of the two listed options, ask again
  until it is.

## 3. Output the selected items (this demo stops here — no real deploy)

Echo the validated selections back to the user exactly, then the plan:

> **Selected environment:** <environment>
> **Selected migrations:** <Yes / No>
>
> Plan: would deploy to **<environment>**, migrations **<yes/no>**.

Do NOT run any real deploy commands — this skill exists to demonstrate
argument handling, not to ship anything.
