# 09 – Configuration & Environment Management

## Goals
* Manage environment-specific values (dev, staging, prod)
* Use `.env` style parsing without external packages (exercise) then consider packages
* Handle secrets responsibly (never commit)

## Simple `.env` Parser
```dart
import 'dart:io';

Future<Map<String,String>> readEnvFile(String path) async {
  final file = File(path);
  if (!await file.exists()) return {};
  final map = <String,String>{};
  await for (final line in file.openRead()
      .transform(SystemEncoding().decoder)
      .transform(const LineSplitter())) {
    final trimmed = line.trim();
    if (trimmed.isEmpty || trimmed.startsWith('#')) continue;
    final idx = trimmed.indexOf('=');
    if (idx == -1) continue;
    final key = trimmed.substring(0, idx);
    final value = trimmed.substring(idx + 1);
    map[key] = value;
  }
  return map;
}
```

## Runtime Selection
```dart
String selectBaseUrl(Map<String,String> env) => switch(env['APP_ENV']) {
  'prod' => 'https://api.prod.example',
  'staging' => 'https://api.staging.example',
  _ => 'http://localhost:3000',
};
```

## Practice
1. Add support for quoted values and escaped `#` characters.
2. Add caching layer so file read occurs once (singleton or top-level `late`).
3. Provide a function that overlays system environment variables on file values.

## Checklist
* [ ] Parser handles comments & whitespace
* [ ] Missing file handled gracefully
* [ ] Secrets not printed accidentally

## Next
Go to 10 (CLI Input & Output Patterns).
