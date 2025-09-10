# 16 – Security & Validation Basics

## Goals
* Input validation & sanitization
* Avoid common injection vectors in CLI / file usage
* Hashing & basic crypto primitives (high-level overview)

## Validation Utility
```dart
Never invalid(String msg) => throw FormatException(msg);

String nonEmpty(String? value, String field) {
  final v = value?.trim();
  if (v == null || v.isEmpty) invalid('$field cannot be empty');
  return v!;
}
```

## Hashing (SHA-256)
```dart
import 'dart:convert';
import 'package:crypto/crypto.dart';

String sha256Hex(String input) => sha256.convert(utf8.encode(input)).toString();
```

## Practice
1. Add email format validator (simple regex, note limitations).
2. Create `sanitizeFilename` removing path separators.
3. Write a function checking password strength heuristics.

## Checklist
* [ ] All external input validated once at boundary
* [ ] No untrusted strings passed to shell commands
* [ ] Cryptography from audited packages (no homemade ciphers)

## Next
17 (Packaging & Distribution).
