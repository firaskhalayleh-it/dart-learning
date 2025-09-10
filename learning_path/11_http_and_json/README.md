# 11 – HTTP & JSON

## Goals
* Perform HTTP GET/POST
* Encode/decode JSON safely
* Handle network errors & timeouts

## Using `http` Package
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String,dynamic>>> fetchTasks(Uri base) async {
  final resp = await http.get(base.resolve('/tasks')).timeout(const Duration(seconds: 5));
  if (resp.statusCode != 200) {
    throw HttpException('Status ${resp.statusCode}');
  }
  final body = jsonDecode(resp.body);
  if (body is! List) throw FormatException('Expected list');
  return body.cast<Map>().map((e) => e.cast<String,dynamic>()).toList();
}
```

## POST Example
```dart
Future<void> createTask(Uri base, Map<String,dynamic> task) async {
  final resp = await http.post(
    base.resolve('/tasks'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(task),
  );
  if (resp.statusCode != 201) {
    throw HttpException('Failed create');
  }
}
```

## Defensive Decoding
```dart
T expectType<T>(Object value, String field) {
  if (value is! T) throw FormatException('Field $field expected $T got ${value.runtimeType}');
  return value;
}
```

## Practice
1. Implement exponential backoff for transient 5xx responses.
2. Add ETag caching logic storing `etag` & conditionally sending `If-None-Match`.
3. Create a CLI `dart run bin/task_cli.dart --sync` that fetches then stores locally.

## Checklist
* [ ] Timeouts configured
* [ ] Errors classified (network vs parse vs server)
* [ ] JSON shape validated

## Next
Move to 12 (Data Persistence & Local Storage).
