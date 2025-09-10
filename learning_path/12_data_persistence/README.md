# 12 – Data Persistence (Files & Simple DBs)

## Goals
* Persist structured data to local files (JSON / binary)
* Simple key-value storage pattern
* Lightweight embedded store (exercise) using `RandomAccessFile`

## JSON File Store
```dart
import 'dart:convert';
import 'dart:io';

class JsonStore<T> {
  final File file;
  final T Function(Map<String,dynamic>) fromMap;
  final Map<String,dynamic> Function(T) toMap;
  JsonStore(this.file, {required this.fromMap, required this.toMap});

  Future<List<T>> readAll() async {
    if (!await file.exists()) return [];
    final text = await file.readAsString();
    if (text.trim().isEmpty) return [];
    final data = jsonDecode(text);
    if (data is! List) throw FormatException('Expected list');
    return data.cast<Map>().map((m) => fromMap(m.cast())).toList();
  }

  Future<void> writeAll(List<T> items) async {
    final tmp = File('${file.path}.tmp');
    await tmp.writeAsString(jsonEncode(items.map(toMap).toList()));
    await tmp.rename(file.path); // atomic-ish swap
  }
}
```

## Binary (Simple Index) – Concept Sketch
```dart
// Layout: [count][entries...]; each entry: [len:uint32][utf8 bytes]
// Build as learning exercise only; not for production scale.
```

## Practice
1. Add a checksum (MD5) footnote to detect corruption.
2. Implement append-only log then compaction to main file.
3. Introduce a lock mechanism preventing concurrent writes.

## Checklist
* [ ] Atomic writes (temp + rename)
* [ ] Input validated before write
* [ ] Corruption yields clear error

## Next
13 (Logging & Observability).
