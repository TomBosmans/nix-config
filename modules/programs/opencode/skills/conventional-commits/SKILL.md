---
name: conventional-commits
description: >-
  Apply Conventional Commits 1.0.0 when writing, reviewing, or interpreting git
  commit messages and release intent.
---

# Conventional Commits 1.0.0

Use the authoritative specification at <https://www.conventionalcommits.org/en/v1.0.0/> when details beyond this summary matter.

## Structure

```text
<type>[optional scope][optional !]: <description>

[optional body]

[optional footer(s)]
```

## Rules

- Use `feat` for a new feature. This correlates with a SemVer minor release.
- Use `fix` for a bug fix. This correlates with a SemVer patch release.
- Other types such as `build`, `chore`, `ci`, `docs`, `perf`, `refactor`, `revert`, `style`, and `test` are allowed.
- An optional scope is a noun in parentheses, for example `fix(parser):`.
- Put a concise description immediately after the colon and space.
- Start an optional body one blank line after the description.
- Start optional footers one blank line after the body.
- Format footer tokens with hyphens instead of spaces, except for `BREAKING CHANGE`.
- Indicate a breaking change with `!` before the colon or a `BREAKING CHANGE: <description>` footer.
- A breaking change correlates with a SemVer major release regardless of commit type.
- Treat types and scopes case-insensitively. `BREAKING CHANGE` must be uppercase.

## Examples

```text
feat(parser): support nested arrays
```

```text
fix: prevent duplicate requests

Keep only the latest in-flight request for each resource.

Refs: #123
```

```text
feat(api)!: remove the legacy endpoint

BREAKING CHANGE: clients must use the v2 endpoint.
```

Prefer splitting unrelated changes into separate commits when they require different types.
