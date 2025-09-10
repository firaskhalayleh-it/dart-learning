# 17 – Packaging & Distribution

## Goals
* Prepare a Dart package for publication (even if private)
* Semantic versioning strategy
* Produce native executables

## Pubspec Essentials
```yaml
name: taskmate_core
description: Core logic for TaskMate CLI
version: 0.1.0
repository: https://example.com/repo
issue_tracker: https://example.com/repo/issues
environment:
  sdk: '>=3.2.0 <4.0.0'
publish_to: 'none' # remove to publish publicly
```

## Native Executable
```bash
dart compile exe bin/task_cli.dart -o build/task
```

## Versioning Guidelines
* PATCH: bug fixes
* MINOR: backward-compatible feature
* MAJOR: breaking change (document migration)

## Practice
1. Add a `CHANGELOG.md` with Unreleased section.
2. Implement `--version` flag printing semantic version.
3. Create release script bundling binary + README into `dist/`.

## Checklist
* [ ] Clear license file
* [ ] Changelog updated per release
* [ ] Version bump matches changeset impact

## Next
18 (Architecture & Domain Refinement).
