# 14 – Advanced Testing & Quality

## Goals
* Property-based test style concepts
* Mutation testing mindset (manual simulation)
* Benchmarks & micro performance checks

## Property-Based Sketch
```dart
import 'dart:math';

void propertyReverseTwice() {
  final r = Random();
  for (var i = 0; i < 500; i++) {
    final len = r.nextInt(200);
    final s = List.generate(len, (_) => String.fromCharCode(r.nextInt(26)+97)).join();
    final rev = s.split('').reversed.join();
    final rev2 = rev.split('').reversed.join();
    assert(s == rev2, 'Reversing twice should yield original');
  }
}
```

## Benchmarking (Simple Stopwatch)
```dart
T measure<T>(String label, T Function() op) {
  final sw = Stopwatch()..start();
  final result = op();
  sw.stop();
  print('$label took ${sw.elapsedMicroseconds}µs');
  return result;
}
```

## Practice
1. Create a benchmarking harness comparing two JSON encode strategies.
2. Simulate mutation by changing a `+` to `-` in a test copy and seeing failing tests.
3. Add coverage run: `dart test --coverage=coverage && format_coverage ...` (research tooling).

## Checklist
* [ ] Property-style tests cover invariants
* [ ] Performance hotspots measured, not assumed
* [ ] Coverage reviewed, not blindly inflated

## Next
15 (Concurrency & Isolates).
