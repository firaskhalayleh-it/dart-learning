# 01 – Environment Setup (Pure Dart)

## Goals
* Install the Dart SDK correctly (pure Dart focus)
* Understand pure Dart package layout
* Use `dart create` for CLI / library projects
* Configure static analysis, formatting, scripts, and dependency management
* Run, test, format, analyze, and profile a Dart project from the terminal

## Install Dart (macOS)
Option A – via Homebrew (keeps SDK updated):
```
brew tap dart-lang/dart
brew install dart
dart --version
```
// (Flutter toolchain intentionally excluded for a Dart-only codebase.)

## Create Pure Dart Projects
1. Simple console app:
```
dart create -t console-full hello_dart
cd hello_dart
dart run
```
2. Library package (for sharing code):
```
dart create -t package my_utils
```
3. Server (shelf) starter:
```
dart create -t server-shelf api_server
cd api_server
dart run bin/server.dart
```

## Directory Anatomy (console-full template)
* `bin/` – entry scripts (`bin/hello_dart.dart`)
* `lib/` – reusable library code (import with `package:hello_dart/hello_dart.dart`)
* `test/` – unit tests (`dart test`)
* `pubspec.yaml` – package metadata & dependencies
* `analysis_options.yaml` – lints (add if missing)
* `tool/` – (optional) custom scripts

## Adding Dependencies
```
dart pub add http
dart pub add dev:build_runner
```
Specific version pin:
```
dart pub add collection:1.18.0
```

## Example Minimal `pubspec.yaml` (Pure Dart)
```yaml
name: hello_dart
description: Example console application
version: 0.1.0
publish_to: 'none'
environment:
  sdk: '>=3.2.0 <4.0.0'
dependencies:
  http: ^1.2.0
dev_dependencies:
  test: ^1.25.0
  lints: ^5.0.0
```

## Recommended `analysis_options.yaml`
Create at project root:
```yaml
include: package:lints/recommended.yaml

analyzer:
  language:
    strict-casts: true
    strict-inference: true
    strict-raw-types: true
  errors:
    unused_import: error
    dead_code: error

linter:
  rules:
    - prefer_const_constructors
    - avoid_print
    - use_super_parameters
```

## Core Commands
```
dart run                # Run entrypoint
dart test               # Execute tests
dart format .           # Format
dart analyze            # Static analysis
dart pub outdated       # View upgradable deps
dart pub upgrade --major-versions
dart compile exe bin/hello_dart.dart -o build/hello   # Native executable
```

## Formatting & CI Hook
Add a simple pre-commit script (optional):
```
#!/usr/bin/env bash
dart format . && dart analyze
```

## Performance Snapshot (Basic)
```
dart compile jit-snapshot bin/hello_dart.dart -o build/hello.jit
```
Or profile run:
```
dart run --observe bin/hello_dart.dart
```
Open printed Observatory URL in browser.

## Common Setup Pitfalls
| Issue | Cause | Fix |
|-------|-------|-----|
| `Command not found: dart` | PATH not exported | Add SDK to PATH (`echo $PATH`) |
| Slow first run | JIT warm-up | Precompile with `dart compile exe` |
| Analyzer warnings noisy | Missing custom config | Add `analysis_options.yaml` |
| Dependency conflicts | Loose constraints | Pin critical versions |

## Practice Tasks
1. Create a `string_tools` package exposing: `String reverse(String)`. Add a test.
2. Add a dependency (`collection`) and use `IterableEquality` in a sample file.
3. Compile to native executable and run it from `./build/`.
4. Run `dart pub outdated` and interpret the table.

## Verification Checklist
* [ ] `dart --version` works
* [ ] `dart run` executes example
* [ ] `dart test` passes
* [ ] Formatting & analysis produce no issues

<!-- Flutter integration intentionally omitted for pure Dart scope. -->

## Next
Proceed to 02 (Dart Basics) for core language fundamentals.
