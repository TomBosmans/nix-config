---
name: semver
description: >-
  Apply Semantic Versioning 2.0.0 when choosing, validating, or explaining
  software version numbers and release increments.
---

# Semantic Versioning 2.0.0

Use the authoritative specification at <https://semver.org/spec/v2.0.0.html> when details beyond this summary matter.

## Version Format

A normal version is `MAJOR.MINOR.PATCH`, where each component is a non-negative integer without leading zeroes.

1. Increment `MAJOR` for incompatible API changes.
2. Increment `MINOR` for backward-compatible functionality or deprecations.
3. Increment `PATCH` for backward-compatible bug fixes.

Reset lower-order components to zero when incrementing a higher-order component.

## Core Rules

- Software using SemVer must declare a public API.
- `0.y.z` is for initial development and may change at any time.
- `1.0.0` defines the first stable public API.
- Released version contents must not be modified. Publish a new version instead.
- Deprecating public API functionality requires at least a minor increment.
- Any backward-incompatible public API change requires a major increment.

## Pre-Releases And Build Metadata

- Add pre-release identifiers after `-`, for example `1.0.0-alpha.1`.
- Pre-release versions have lower precedence than the associated normal version.
- Add build metadata after `+`, for example `1.0.0+20261009`.
- Build metadata does not affect precedence.
- Identifiers contain ASCII alphanumerics and hyphens and must not be empty.
- Numeric identifiers must not contain leading zeroes.

## Precedence

Compare major, minor, and patch numerically in that order. When those are equal:

1. A version without a pre-release field has higher precedence.
2. Compare dot-separated pre-release identifiers from left to right.
3. Compare numeric identifiers numerically.
4. Numeric identifiers have lower precedence than non-numeric identifiers.
5. Compare non-numeric identifiers lexically in ASCII order.
6. A larger set of equal-prefix identifiers has higher precedence.

Ignore build metadata when determining precedence.
