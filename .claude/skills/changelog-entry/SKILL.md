---
name: changelog-entry
description: >-
  Add a new entry to CHANGELOG.md in the project's Keep a Changelog format.
  Use this whenever the user wants to record a change, cut a release note,
  or asks to "add a changelog entry", "update the changelog", or "note this
  in the changelog".
allowed-tools:
  - Read
  - Edit
  - Bash
---

# Changelog Entry

Add a well-formed entry to `CHANGELOG.md` following the
[Keep a Changelog](https://keepachangelog.com) convention.

## Steps

1. Read `CHANGELOG.md`. If it does not exist, create it with a standard
   header and an `## [Unreleased]` section.
2. Determine the category from the change. Use exactly one of:
   `Added`, `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security`.
3. Run the helper to generate a correctly formatted line:
   ```bash
   python3 .claude/skills/changelog-entry/format_entry.py "<category>" "<description>"
   ```
4. Insert the returned line under the matching category heading inside
   `## [Unreleased]`, creating the category heading if it's missing.
5. Show the user the diff. Do NOT commit unless they ask.

## Rules

- One change per entry. Split multiple changes into multiple entries.
- Write descriptions in the imperative past tense ("Added X", "Fixed Y").
- Never invent a version number — new work always lands under `[Unreleased]`.
