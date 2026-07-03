#!/usr/bin/env python3
"""Format a single Keep a Changelog entry line.

Usage: format_entry.py <category> <description>
Prints a normalized "- <description>" bullet, validating the category.
"""
import sys

VALID = {"Added", "Changed", "Deprecated", "Removed", "Fixed", "Security"}


def main() -> int:
    if len(sys.argv) != 3:
        print("usage: format_entry.py <category> <description>", file=sys.stderr)
        return 2
    category, description = sys.argv[1], sys.argv[2].strip()
    if category not in VALID:
        print(f"invalid category {category!r}; use one of {sorted(VALID)}",
              file=sys.stderr)
        return 1
    if not description:
        print("description must not be empty", file=sys.stderr)
        return 1
    # Ensure the bullet starts capitalized and has no trailing period.
    description = description[0].upper() + description[1:]
    description = description.rstrip(".")
    print(f"- {description}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
