# Dart Learning Path (Intro to Flutter)

Welcome! This repository is a structured, hands-on learning path to take you from zero (or near-zero) in Dart to being ready to start building Flutter apps confidently.

## Why This Path?
Flutter development benefits greatly from strong Dart fundamentals: async programming, null safety, clean architecture, testing, and structured thinking. This curriculum builds these skills *incrementally* using a small evolving domain: a "Task & Ticket Tracker" service.

## Who Is This For?
- Beginners with some general programming exposure.
- Developers from JavaScript/Java/Python/Kotlin wanting a fast ramp-up.
- Anyone preparing to jump into Flutter.

## Learning Philosophy
1. Explain → Demonstrate → Practice → Reflect.
2. Realistic mini-domain instead of contrived examples.
3. Encourage iteration and refactoring.
4. Promote test-first (from Module 11 onward).
5. Show idiomatic Dart (effective use of null safety, immutable patterns, streams, futures).

## Curriculum Overview
| # | Module | Focus | Output |
|---|--------|-------|--------|
| 0 | Overview & Setup | Environment, tooling, first "Hello" | Working dev setup |
| 1 | Variables & Types | Null safety, type inference, collections | Task data structures |
| 2 | Functions & Methods | Parameters, returns, named params, arrow syntax | Task utilities |
| 3 | Classes & Objects | Constructors, properties, methods, privacy | Task and User classes |
| 4 | Inheritance & Mixins | Extends, implements, mixins, abstract classes | Task type hierarchy |
| 5 | Enums & Pattern Matching | Enums, switch expressions, sealed classes | TaskStatus, Priority |
| 6 | Error Handling | Exceptions, try/catch, Result patterns | Robust task operations |
| 7 | Collections Deep Dive | Lists, Sets, Maps, iterables, functional ops | Task filtering/sorting |
| 8 | Async Programming I | Future, async/await, error handling | Task loading/saving |
| 9 | Async Programming II | Streams, Stream transformations | Real-time task updates |
| 10 | Libraries & Packages | Creating libraries, pub.dev, exports | Task service library |
| 11 | Testing Fundamentals | Unit tests, matchers, test organization | Task model tests |
| 12 | Advanced Testing | Mocking, async tests, test-driven development | Service layer tests |
| 13 | JSON & Serialization | JSON parsing, serialization patterns | Task persistence |
| 14 | Architecture Patterns | Repository pattern, dependency injection | Clean task architecture |
| 15 | Flutter Preparation | Widget concepts, state management prep | Ready for Flutter! |

## Getting Started

### Prerequisites
- Dart SDK 3.2.0 or later
- VS Code with Dart extension (recommended) or your preferred editor
- Git for version control

### Setup
1. Clone this repository:
   ```bash
   git clone https://github.com/firaskhalayleh-it/dart-learning.git
   cd dart-learning
   ```

2. Install dependencies:
   ```bash
   dart pub get
   ```

3. Verify your setup:
   ```bash
   dart run bin/list_tickets.dart
   ```

4. Run tests to ensure everything works:
   ```bash
   dart test
   ```

### How to Use This Repository

1. **Start with the curriculum files** in `curriculum/` to understand the learning objectives.

2. **Work through modules sequentially** in `modules/01_fundamentals/` through `modules/15_flutter_prep/`.

3. **Each module contains**:
   - `README.md` - Learning objectives, concepts, and instructions
   - `examples/` - Demonstration code
   - `exercises/` - Practice problems
   - `solutions/` - Reference implementations (complete where provided)

4. **Practice with the evolving domain**: The "Task & Ticket Tracker" grows more sophisticated as you progress.

5. **Test your understanding**: Run tests and create your own as you learn.

6. **Build incrementally**: Each module builds on previous concepts.

## Learning Path Structure

```
dart-learning/
├── curriculum/           # Learning narrative and objectives
├── modules/             # 15 progressive modules
│   ├── 01_fundamentals/
│   ├── 02_variables_types/
│   ├── ...
│   └── 15_flutter_prep/
├── flutter_prep/       # Flutter-ready foundation code
│   └── minimal_foundation/
├── bin/                # Utility scripts
├── tests/              # Sample tests
└── docs/               # Additional documentation
```

## Key Learning Outcomes

By the end of this path, you'll be comfortable with:

- **Dart Fundamentals**: Syntax, type system, null safety
- **Object-Oriented Programming**: Classes, inheritance, mixins, patterns
- **Async Programming**: Futures, Streams, error handling
- **Testing**: Unit tests, mocking, TDD practices
- **Architecture**: Clean code principles, separation of concerns
- **Flutter Readiness**: State management concepts, widget thinking

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on improving this learning path.

## Resources

- [Official Dart Documentation](https://dart.dev/guides)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter Documentation](https://flutter.dev/docs)

## License

This learning path is open source and available under the MIT License.

---

**Ready to start?** Begin with [curriculum/00_overview.md](curriculum/00_overview.md) and then move to [modules/01_fundamentals/](modules/01_fundamentals/).